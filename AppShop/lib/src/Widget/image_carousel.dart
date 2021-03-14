import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
  final List<String> imageList=[
    "https://cf.shopee.vn/file/064a5e956bb4481b405838d2207553f7",
    "https://cf.shopee.vn/file/0bacc69f53fb01e2ff5852e4b3bb45d8",
    "https://cf.shopee.vn/file/cd49472722264872116af1791c9fb128",
    "https://cf.shopee.vn/file/19ceb5c4c41088022eef35f10f8f39a0",
    "https://cf.shopee.vn/file/b87bdee3cd8a5a6b1b2b1b8f275c2690",
  ];
  var imageListlength=imageList.length;
  final List<String> bgImangeList=[
    "https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/v748-toon-15_1_1.jpg?w=1300&dpr=1&fit=default&crop=default&q=80&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=c360b9d7d2e1d262ed342a05f0787450",
  ];

  var color=[
    0xFFF44336,
    0xFFFF9800,
    0xFFFFEB3B,
    0xFF4CAF50,
    0xFF2196F3
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  final List child = map<Widget>(
    imageList,
        (index, i) {
      return Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(children: <Widget>[
            InkWell(
              child: Image.network(i, fit: BoxFit.fill,height: 250.0,)
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
            ),
          ]),
        ),
      );
    },
  ).toList();
  class image_carousel extends StatefulWidget {
    @override
    _image_carouselState createState() => _image_carouselState();
  }
  class _image_carouselState extends State<image_carousel> {
    int _current = 0;
    @override
    Widget build(BuildContext context) {
      return SizedBox(
        child: Stack(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                child: TweenAnimationBuilder(
                tween: ColorTween(begin:Color(color[_current]) ,end:(_current==imageListlength-1) ? Color(color[0]) : Color(color[_current+1])),
                duration: Duration(milliseconds: 500),
                builder: (_,  Color color, __){
                  return ColorFiltered(
                    child: SizedBox(child: Image.network(bgImangeList[0],fit: BoxFit.fill,height: 250.0,)),
                    colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                  );
                }
            ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: Column(children: [
                Stack(
                  children: <Widget>[
                    CarouselSlider(
                      items: child,
                      autoPlay: true,
                      pauseAutoPlayOnTouch: Duration(days: 2),
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  Positioned(
                    bottom: 12.0,
                    right: 0.0,
                    left: 0.0,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map<Widget>(
                        imageList,
                            (index, url) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(255, 255, 255, 0.9)
                                    : Color.fromRGBO(255, 255, 255, 0.4)),
                          );
                        },
                      ),
                    ),
                  )
                  ],
                ),
              ]),
            ),
          ],
        ),
      );
    }
  }