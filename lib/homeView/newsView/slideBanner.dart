import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

final List<String> publicImgList = [
  'assets/images/1.jpg',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
];

class SlideBanner extends StatefulWidget {
  SildeBannerState createState() => new SildeBannerState();
}

class SildeBannerState extends State<SlideBanner> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(BorderRadius.circular(15.0),),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Swiper(
            autoplay: true,
            scale: 0.8,
            viewportFraction: 1,
            pagination: SwiperPagination(),
            itemCount: publicImgList.length,
            itemBuilder: (BuildContext context, int index) {
             return Image.asset(publicImgList[index]);
            }
          ) // Swiper
        ),
      ), // Padding
    ); // Container
  }
}
