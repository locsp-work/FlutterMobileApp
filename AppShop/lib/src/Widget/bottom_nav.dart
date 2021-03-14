import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop/src/page/MainPage.dart';
import 'package:my_shop/src/page/OrderNotification.dart';
import 'package:my_shop/src/page/SettingPage.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:provider/provider.dart';
class BottomNav extends StatefulWidget {
  final String currentUserId;
  BottomNav({Key navigationKey,this.currentUserId}) : super(key: navigationKey);
  @override
  _BottomNavState createState() => _BottomNavState();
}
class _BottomNavState extends State<BottomNav> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  int _selectIndex=0;
  List<GlobalKey<NavigatorState>> _navigatorKey=[
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  GlobalKey _bottomNavigationKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        final isFirstRouteInCurrentTab=!await _navigatorKey[_selectIndex].currentState.maybePop();
        print('isFirstRouteInCurrentTab'+ isFirstRouteInCurrentTab.toString());
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.lightBlue[900],
            buttonBackgroundColor: Colors.lightBlueAccent[700],
            backgroundColor: Colors.lightBlue[100],
            height: 50.0,
            key: _bottomNavigationKey,
            items: <Widget>[
              Icon(Icons.home, size: 24,color: Colors.yellowAccent[100],),
              Icon(Icons.notifications,size: 24,color: Colors.yellowAccent[100],),
              Icon(Icons.account_circle, size: 24,color: Colors.yellowAccent[100],)
            ],
            onTap: (index){
              setState(() {
                _selectIndex=index;
              });
            },
          ),
          body: Stack(
            children: <Widget>[
              _buildOffstageNavigation(0),
              _buildOffstageNavigation(1),
              _buildOffstageNavigation(2),
            ],
          )
      ),
    );
  }
  void next(Widget ct){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ct));
  }
  Map<String,WidgetBuilder> _routeBuilder(BuildContext context,int index){
    final user=Provider.of<UserProvider>(context);
    return{
      '/':(context){
        return [
          MainPage(),
          OrderCheck(),
          SettingPage(currentUser: user.userModel,),
        ].elementAt(index);
      }
    };
  }
  Widget _buildOffstageNavigation(int index){
    var routeBuilders=_routeBuilder(context, index);
    return Offstage(
        offstage: _selectIndex != index,
        child: Navigator(
          key: _navigatorKey[index],
          onGenerateRoute: (routeSettings){
            return MaterialPageRoute(
              builder: (context)=>routeBuilders[routeSettings.name](context),
            );
          },
        )
    );
  }
}
