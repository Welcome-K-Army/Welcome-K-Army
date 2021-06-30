import 'package:flutter/material.dart';
import 'package:Army/constants.dart';
import 'package:Army/services/helper.dart';
import 'package:Army/ui/auth/authScreen.dart';
import 'package:Army/assets/custom_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  final List<String> _titlesList = [
    '켠김에 별까지',
    '검색 기능',
    '일정 관리',
    '당신의 군생활을 응원합니다.'
  ];

  final List<String> _subtitlesList = [
    '\'켠김에 별까지\'는 직업군인이 되고싶어하는 사람들을\n 위해 개발 어플리케이션 솔루션입니다.',
    '구글맵과 연동되는 검색과 필터링 기능 제공으로\n위치와 정보를 직관적으로 열람할 수 있습니다.',
    '각 학교별 일정 관리와 개인 맞춤형 일정관리를 제공합니다.',
    ''
  ];

  final List<dynamic> _imageList = [
    CustomIcons.go2star,
    Icons.manage_search,
    Icons.calendar_today_outlined,
    Icons.auto_awesome
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            itemBuilder: (context, index) => getPage(_imageList[index], _titlesList[index], _subtitlesList[index], context, index + 1 == _titlesList.length),
            controller: pageController,
            itemCount: _titlesList.length,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: pageController,
                count: _titlesList.length,
                effect: ScrollingDotsEffect(activeDotColor: Color(COLOR_PRIMARY), dotColor: Colors.grey.shade400, dotWidth: 8, dotHeight: 8),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getPage(dynamic image, String title, String subTitle, BuildContext context, bool isLastPage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        image is String
            ? Image.asset(
                image,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              )
            : Icon(
                image as IconData,
                color: Color(COLOR_PRIMARY),
                size: 150,
              ),
        SizedBox(height: 40),
        Text(
          title.toUpperCase(),
          style: TextStyle(color: Color(COLOR_PRIMARY), fontSize: 25.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _currentIndex + 1 == _titlesList.length
              ? OutlineButton(
                  onPressed: () {
                    setFinishedOnBoarding();
                    pushReplacement(context, new AuthScreen()); 
                  },
                  child: Text("시작하기",
                    style: TextStyle(fontSize: 20.0, color: Color(COLOR_PRIMARY), fontWeight: FontWeight.bold),
                  ),
                  borderSide: BorderSide(color: Color(COLOR_PRIMARY)),
                  shape: StadiumBorder(),
                )
              : Text(
                  subTitle,
                  style: TextStyle(color: Color(COLOR_PRIMARY), fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
        ),
      ],
    );
  }

  Future<bool> setFinishedOnBoarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(FINISHED_ON_BOARDING, true);
  }
}
