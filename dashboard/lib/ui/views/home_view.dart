
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardadmin/Services/firestore_service.dart';
import 'package:dashboardadmin/constants/routes.dart';
import 'package:dashboardadmin/ui/views/ChatList.dart';
import 'package:dashboardadmin/ui/views/OrderCheck.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dashboardadmin/Services/navigation_service.dart';
import 'package:dashboardadmin/Services/authentication_service.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChatRoom.dart';
class HomeView extends StatefulWidget
{
  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView>{
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService= locator<FirestoreService>();
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  String currentUserId;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
//    registerNotification();
    configLocalNotification();
    super.initState();
  }
  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ?? 'com.myshop.dashboardadmin',
      'Shop Admin',
      'your notification',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    print(message);
    await flutterLocalNotificationsPlugin.show(
        0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }
//  void registerNotification() {
//    firebaseMessaging.requestNotificationPermissions();
//
//    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
//      print('onMessage: $message');
//      Platform.isAndroid ? showNotification(message['notification']) : showNotification(message['aps']['alert']);
//      return;
//    }, onResume: (Map<String, dynamic> message) {
//      print('onResume: $message');
//      return;
//    }, onLaunch: (Map<String, dynamic> message) {
//      print('onLaunch: $message');
//      return;
//    });
//
//    firebaseMessaging.getToken().then((token) {
//      print('token: $token');
//      Firestore.instance.collection('users').document(_authenticationService.currentUser.id).updateData({'pushToken': token});
//    });
//  }

  void configLocalNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  @override
  Widget build(BuildContext context)
  {
    final primaryColor = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: ()=> _navigationService.ExitApp(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Text('Dashboard', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
          actions: <Widget>
          [
            RaisedButton(
              color: Colors.white,
              shape: CircleBorder(),
              onPressed: () {
                (fabKey.currentState.isOpen) ? fabKey.currentState.close() : fabKey.currentState.open();
              },
            ),
          ],
        ),
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
//            _buildTile(
//              Padding
//              (
//                padding: const EdgeInsets.all(24.0),
//                child: Row
//                (
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>
//                  [
//                    Column
//                    (
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>
//                      [
//                        Text('Total Views', style: TextStyle(color: Colors.blueAccent)),
//                        Text('265K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
//                      ],
//                    ),
//                    Material
//                    (
//                      color: Colors.blue,
//                      borderRadius: BorderRadius.circular(24.0),
//                      child: Center
//                      (
//                        child: Padding
//                        (
//                          padding: const EdgeInsets.all(16.0),
//                          child: Icon(Icons.timeline, color: Colors.white, size: 30.0),
//                        )
//                      )
//                    )
//                  ]
//                ),
//              ),
//            ),
            _buildTile(
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderCheck()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Material
                      (
                        color: Colors.teal,
                        shape: CircleBorder(),
                        child: Padding
                        (
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.notifications_active, color: Colors.white, size: 30.0),
                        )
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('Orders', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0)),
                    ]
                  ),
                ),
              ),
            ),
            _buildTile(
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatList(_authenticationService.currentUser.id,_authenticationService.currentUser.fullName)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Material
                      (
                        color: Colors.amber,
                        shape: CircleBorder(),
                        child: Padding
                        (
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.message, color: Colors.white, size: 30.0),
                        )
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('Messenger', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0)),
                    ]
                  ),
                ),
              ),
            ),
            _buildTile(
              Padding
                (
                padding: const EdgeInsets.all(24.0),
                child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>
                    [
                      Column
                        (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Text('Shop Category', style: TextStyle(color: Colors.redAccent)),
//                          Text('${_firestoreService.}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                        ],
                      ),
                      Material
                        (
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50.0),
                          child: Center
                            (
                              child: Padding
                                (
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.format_list_numbered, color: Colors.white, size: 30.0),
                              )
                          )
                      )
                    ]
                ),
              ),
              onTap: ()=>{_navigationService.navigateTo(ShopCatViewRoute)}
            ),
            _buildTile(
              Padding
              (
                padding: const EdgeInsets.all(24.0),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Column
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        Text('Shop Items', style: TextStyle(color: Colors.redAccent)),
//                        Text('173', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                      ],
                    ),
                    Material
                    (
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50.0),
                      child: Center
                      (
                        child: Padding
                        (
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.store, color: Colors.white, size: 30.0),
                        )
                      )
                    )
                  ]
                ),
              ),
              onTap: () => _navigationService.navigateTo(ShopItemViewRoute)
            )
          ],
          staggeredTiles: [
//            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(2, 110.0),

          ],
        ),
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            key: fabKey,
            alignment: Alignment.topRight,
            ringColor: Colors.black,
            ringDiameter: 300.0,
            ringWidth: 100.0,
            fabSize: 64.0,
            fabElevation: 8.0,
            fabColor: Colors.white,
            fabMargin: EdgeInsets.all(16.0),
            fabOpenIcon: Icon(Icons.menu, color: primaryColor),
            fabCloseIcon: Icon(Icons.close, color: primaryColor),
            animationDuration: const Duration(milliseconds: 800),
            animationCurve: Curves.easeInOutCirc,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {},
                shape: CircleBorder(),
                padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
  //                child: Image.network(''),
                  )
            ),
              RawMaterialButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: '${_authenticationService.currentUser.email}');
                },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.email,size: 30.0,color: Colors.white,)
              ),
              RawMaterialButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: '${_authenticationService.currentUser.fullName}');
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.account_circle,size: 30.0,color: Colors.white,)
              ),
              RawMaterialButton(
                  onPressed: ()async{
                    await _authenticationService.signOut();
                    _navigationService.pushNamedAndRemoveUntil(StartUpViewRoute,LoginViewRoute);
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.clear,size: 30.0,color: Colors.white,)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell
      (
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
    );
  }
}