import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

final List<String> imgList = [
  'https://reasley.com/wp-content/uploads/2020/04/one.jpg',
  'https://reasley.com/wp-content/uploads/2020/04/two.jpg',
  'https://reasley.com/wp-content/uploads/2020/04/three.jpg'
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
              scale: 1,
              viewportFraction: 0.8,
              pagination: SwiperPagination(),
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(imgList[index]);
              }) // Swiper
          ), // Padding
    ); // Container
  }
}
