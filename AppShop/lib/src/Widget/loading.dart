import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_shop/src/Widget/style.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.redAccent,
          child: SpinKitCubeGrid(
            color: white,
            size: 30,
          )
      ),
    );
  }
}