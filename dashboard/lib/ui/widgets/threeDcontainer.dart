import 'package:flutter/material.dart';

class ThreeDContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color backgroundDarkerColor;
  final Color borderColor;
  final Color borderDarkerColor;
  final double spreadRadius;
  final double offset;
  final double blurRadius;
  const ThreeDContainer({
    Key key,
    @required this.child,
    @required this.width,
    @required this.height,
    @required this.backgroundColor,
    @required this.backgroundDarkerColor,
    this.borderColor,
    this.borderDarkerColor,
    this.blurRadius = 15,
    this.spreadRadius = 4,
    this.offset = 4,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(offset, offset),
              blurRadius: blurRadius,
              spreadRadius: spreadRadius),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-offset, -offset),
              blurRadius: blurRadius,
              spreadRadius: spreadRadius),
        ],
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            borderDarkerColor ?? Colors.black45,
            borderColor ?? Colors.white,
          ],
        ),
      ),
      child: Container(
        width: width,
        height: height,
        child: child,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                backgroundDarkerColor,
                backgroundColor,
              ],
            )),
      ),
    );
  }
}