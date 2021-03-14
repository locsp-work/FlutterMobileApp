import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final bool softWrap;
  final int maxLine;
  final TextOverflow textOverflow;
  final TextDecoration decoration;
  const TitleText(
      {Key key,
        this.text,
        this.fontSize = 18,
        this.color = Colors.black54,
        this.fontWeight = FontWeight.w800,
        this.softWrap = true,
        this.maxLine=1,
        this.textOverflow=TextOverflow.ellipsis,
        this.decoration=TextDecoration.none
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,maxLines: maxLine,softWrap: softWrap,overflow: textOverflow,
        style: GoogleFonts.muli(
            decoration: decoration,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color));
  }
}