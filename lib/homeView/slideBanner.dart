import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

final List<String> imgList = [
  'images/1.jpg',
  'images/2.jpg',
  'images/3.jpg',
];

class SlideBanner extends StatefulWidget {
  SildeBannerState createState() => new SildeBannerState();
}

class SildeBannerState extends State<SlideBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEDF0F4),
      height: 280,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Swiper(
              autoplay: true,
              scale: 0.8,
              viewportFraction: 1,
              pagination: SwiperPagination(),
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(imgList[index]);
              }) // Swiper
          ), // Padding
    ); // Container
  }
}
