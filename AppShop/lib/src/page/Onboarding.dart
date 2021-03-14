//import 'package:flutter/material.dart';
//import 'package:my_shop/src/Widget/Screen_navigation.dart';
//import 'package:my_shop/src/provider/category.dart';
//import 'package:my_shop/src/provider/products.dart';
//import 'package:my_shop/src/provider/user_provider.dart';
//import 'package:provider/provider.dart';
//
//class OnBoarding extends StatefulWidget {
//  @override
//  _OnBoardingState createState() => _OnBoardingState();
//}
//
//const brightYellow = Color(0xFFFFD300);
//const darkYellow = Color(0xFFFFB900);
//
//class _OnBoardingState extends State<OnBoarding> {
//  @override
//  Widget build(BuildContext context) {
//    final _userProvider=Provider.of<UserProvider>(context);
//    final categoryProvider = Provider.of<CategoryProvider>(context);
//    final productProvider = Provider.of<ProductProvider>(context);
//    return Scaffold(
//      backgroundColor: brightYellow,
//      body: Column(
//        children: [
////          Flexible(
////            flex: 8,
////            child: FlareActor(
////              'assets/Filip.flr',
////              alignment: Alignment.center,
////              fit: BoxFit.contain,
////              animation: 'driving',
////            ),
////          ),
//          Flexible(
//            flex: 2,
//            child: RaisedButton(
//              color: darkYellow,
//              elevation: 4,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(50)),
//              child: Text(
//                'Tap here to next',
//                style: TextStyle(color: Colors.black54),
//              ),
//              onPressed: ()async {
//                await _userProvider.signInAnonymously();
//                categoryProvider.loadCategories();
//                productProvider.loadProducts();
//              }
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}