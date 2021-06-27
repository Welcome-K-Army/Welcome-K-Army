import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import '../mode/item_holder.dart';
import '../mode/pdf_items.dart';

const debug = true;

class DownloaderWidget extends StatefulWidget with WidgetsBindingObserver {
  final TargetPlatform? platform;
  final PdfItem pdfItem;
  DownloaderWidget({Key? key, this.platform, this.pdfItem}) : super(key: key);

  @override
  _DownloaderWidgetState createState() => new _DownloaderWidgetState({
        name: pdfItem.title,
        link: pdfItem.url
      });
}

class _DownloaderWidgetState extends State<DownloaderWidget> {
  final _documents;
  final name;
  final url;

  _TaskInfo? _tasks;
  late _ItemHolder _items;
  late bool _isLoading;
  late bool _permissionReady;
  late String _localPath;
  ReceivePort _port = ReceivePort();

  _DownloaderWidgetState({this.name, this.url});

  void initDownloader() {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: debug);
  }

  @override
  void initState() {
    super.initState();
    initDownloader();
    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _isLoading = true;
    _permissionReady = false;
    _documents = {
      'name': name,
      'url': url
    };
    _prepare();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      if (debug) {
        print('UI Isolate Callback: $data');
      }
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];

      if (_tasks != null && _tasks!.isNotEmpty) {
        final task = _tasks!.firstWhere((task) => task.taskId == id);
        setState(() {
          task.status = status;
          task.progress = progress;
        });
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print('Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([
      id,
      status,
      progress
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _permissionReady ? _buildDownload() : _buildNoPermissionWarning());
  }

  Widget _buildDownload() => items.task == null
      ? Container()
      : DownloadItem(
          data: items,
          onItemClick: (task) {
            _openDownloadedFile(task).then((success) {
              if (!success) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Cannot open this file')));
              }
            });
          },
          onActionClick: (task) {
            if (task.status == DownloadTaskStatus.undefined) {
              _requestDownload(task);
            } else if (task.status == DownloadTaskStatus.running) {
              _pauseDownload(task);
            } else if (task.status == DownloadTaskStatus.paused) {
              _resumeDownload(task);
            } else if (task.status == DownloadTaskStatus.complete) {
              _delete(task);
            } else if (task.status == DownloadTaskStatus.failed) {
              _retryDownload(task);
            }
          },
        );

  Widget _buildNoPermissionWarning() => IconButton(
        icon: Icon(Icons.copy),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("권한 없음"),
                content: SingleChildScrollView(child: new Text("저장소 접근 권한을 허용해주세요!")),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("권한 허용"),
                    onPressed: () {
                      _retryRequestPermission();
                      Navigator.pop(context);
                    },
                  ),
                  new FlatButton(
                    child: new Text("닫기"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        },
      );

  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }

    setState(() {
      _permissionReady = hasGranted;
    });
  }

  void _requestDownload(_TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
        url: task.link!,
        headers: {
          "auth": "test_for_sql_encoding"
        },
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true);
  }

  void _cancelDownload(_TaskInfo task) async {
    await FlutterDownloader.cancel(taskId: task.taskId!);
  }

  void _pauseDownload(_TaskInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId!);
  }

  void _resumeDownload(_TaskInfo task) async {
    String? newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  void _retryDownload(_TaskInfo task) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(_TaskInfo? task) {
    if (task != null) {
      return FlutterDownloader.open(taskId: task.taskId!);
    } else {
      return Future.value(false);
    }
  }

  void _delete(_TaskInfo task) async {
    await FlutterDownloader.remove(taskId: task.taskId!, shouldDeleteContent: true);
    await _prepare();
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (widget.platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<Null> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    _tasks = [];

    _tasks = _TaskInfo(name: document['name'], link: document['link']);
    _items = _ItemHolder(name: _tasks!.name, task: _tasks!);
    tasks!.forEach((task) {
      for (_TaskInfo info in _tasks!) {
        if (info.link == task.url) {
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
        }
      }
    });

    _permissionReady = await _checkPermission();

    if (_permissionReady) {
      await _prepareSaveDir();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())! + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    final directory = widget.platform == TargetPlatform.android ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    return directory?.path;
  }
}

class DownloadItem extends StatelessWidget {
  final _ItemHolder? data;
  final Function(_TaskInfo?)? onItemClick;
  final Function(_TaskInfo)? onActionClick;

  DownloadItem({this.data, this.onItemClick, this.onActionClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: InkWell(
        onTap: data!.task!.status == DownloadTaskStatus.complete
            ? () {
                onItemClick!(data!.task);
              }
            : null,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 64.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _buildActionForTask(data!.task!),
              ),
            ),
            data!.task!.status == DownloadTaskStatus.running || data!.task!.status == DownloadTaskStatus.paused
                ? Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: LinearProgressIndicator(
                      value: data!.task!.progress! / 100,
                    ),
                  )
                : Container()
          ].toList(),
        ),
      ),
    );
  }

  Widget? _buildActionForTask(_TaskInfo task) {
    if (task.status == DownloadTaskStatus.undefined || task.status == DownloadTaskStatus.complete || task.status == DownloadTaskStatus.canceled) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: Icon(Icons.file_download),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: Icon(
          Icons.pause,
          color: Colors.red,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.failed) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: Icon(
          Icons.refresh,
          color: Colors.green,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.enqueued) {
      return Text('Pending', style: TextStyle(color: Colors.orange));
    } else {
      return null;
    }
  }
}
