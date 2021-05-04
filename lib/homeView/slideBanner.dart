import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

final List<String> imgList = [
  'https://reasley.com/wp-content/uploads/2020/04/one.jpg',
  'https://reasley.com/wp-content/uploads/2020/04/twojpg',
  'https://reasley.com/wp-content/uploads/2020/04/three.jpg'
];

class SlideBanner extends StatefulWidget {
  SildeBannerState createState() => new SlideBannerState();
}

class SildeBannerState extends State<SlideBanner> {
  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 250,
        child: Padding(
            padding: EdgesInsets.all(10),
            child: Swiper(
                control: SwiperControl(),
                pagination: SwiperPagination(),
                itemCount: imgList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(imgList[index]);
                }) // Swiper
            ), // Padding
      ), // Container
    ); // Scaffold
  }
}
