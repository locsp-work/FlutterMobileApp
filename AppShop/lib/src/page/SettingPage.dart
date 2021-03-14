import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_shop/src/Widget/Screen_navigation.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/model/Users.dart';
import 'package:my_shop/src/page/LoginPage.dart';
import 'package:my_shop/src/page/historyOrder.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  SettingPage({key: Key,this.currentUser});
  final UserModel currentUser;
  @override
  _SettingPageState createState() =>_SettingPageState();
}
class _SettingPageState extends State<SettingPage> {
  @override
  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context){
    final user=Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton:Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 30,
        width: 100,
        child: FloatingActionButton(
            onPressed: (){user.signOut();},
            shape: RoundedRectangleBorder(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Sign out'),
                Icon(Icons.arrow_forward),
              ],
            )
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 110.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo.shade300, Colors.indigo.shade500]
              ),
            ),
          ),
          ListView.builder(
            itemCount: 3,
            itemBuilder: _mainListBuilder,
          ),
        ],
      ),
    );
  }
  Widget _mainListBuilder(BuildContext context, int index) {
    if(index==0) return _buildHeader(context);
    if(index==1) return Container(
      color: Colors.white,
      child: InkWell(
        child:new ListTile(
          title: Row(
            children: <Widget>[
              Icon(Icons.event_note),
              Text('Đơn mua'),
              SizedBox(width: 75.0,),
              Text('xem lịch sử mua hàng',style: TextStyle(fontSize: 12.0),),
              Icon(Icons.arrow_forward_ios,size: 12.0,)
            ],
          ),
        ),
        onTap: (){
          changeScreen(context,HistoryOrder());
        },
      ),
    );
  }
  Container _buildHeader(BuildContext context) {
    final user= Provider.of<UserProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 5.0, right: 5.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0,),
                  Row(children:<Widget>[
                    Expanded(
                      child: InkWell(
                        child: ListTile(
                          title:Text('${user.userModel?.email}',overflow: TextOverflow.clip,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),textAlign: TextAlign.center,),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(height: 5.0,),
                  Container(
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.wallet),
                                Text('Chờ xác nhận',style: TextStyle(fontSize: 10.0),)
                              ],
                            ),
                            onTap: (){
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.truck),
                                Text('Chờ lấy hàng',style: TextStyle(fontSize: 10.0),)
                              ],
                            ),
                            onTap: (){
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.shippingFast),
                                Text('Đang giao',style: TextStyle(fontSize: 10.0),)
                              ],
                            ),
                            onTap: (){

                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.check),
                                Text('Thành công',style: TextStyle(fontSize: 10.0),)
                              ],
                            ),
                            onTap: (){
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            left: 0,
            right: 0,
            child: AvatarGlow(
                glowColor: Colors.red,
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.lightBlue[200],
                    child: TitleText(text:'${user.userModel?.name?.toUpperCase()}'))),
                endRadius: 80),
          )
        ],
      ),
    );
  }
}


