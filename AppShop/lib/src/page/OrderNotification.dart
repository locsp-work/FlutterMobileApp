import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_shop/src/Widget/Screen_navigation.dart';
import 'package:my_shop/src/Widget/loading.dart';
import 'package:my_shop/src/Widget/style.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/page/OrderInfo.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:provider/provider.dart';
class OrderCheck extends StatefulWidget {
  @override
  _OrderCheckState createState() => _OrderCheckState();
}

class _OrderCheckState extends State<OrderCheck> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context);
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('orders').where('userId',isEqualTo: user.user.uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Loading();
          }else{
            return ListView(
                children:snapshot.data.documents.map((DocumentSnapshot document){
                  return Stack(
                    children: <Widget>[
                      Card(
                        child:InkWell(
                          onTap: (){
                            changeScreen(context, OrderInfo(cartId: document['id'],));
                          },
                          child: Container(
                              height: 80.0,
                              width: 330,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Icon(FontAwesomeIcons.wallet),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          children: <Widget>[
                                            Text('State ${document['status']}'),
                                            Text('Date ${DateTime.fromMillisecondsSinceEpoch(document['createdAt']*1000)}'),
                                            Text('${document['total']}đ')
                                          ],
                                        )
                                    )
                                  ]
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 3,
                        child: IconButton(
                          icon: Icon(Icons.close,size: 30,color: Colors.red,),
                          onPressed: (){
                            if(document['status']=='Đang chờ'){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.0)), //this right here
                                      child: Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              TitleText(text: 'Xóa đơn hàng',fontSize: 20,fontWeight: FontWeight.w900,),
                                              Text('Đơn hàng ${document['id']} sẽ bị xóa', textAlign: TextAlign.center,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 100.0,
                                                    child: RaisedButton(
                                                      onPressed: () {
                                                        document.reference.delete();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Accept",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      color: const Color(0xFF1BC0C5),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100.0,
                                                    child: RaisedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                        color: red
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }else{
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.0)), //this right here
                                      child: Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(child: TitleText(text:'Đơn hàng của bạn đã được xác nhận nên không thể xóa',maxLine: 4,fontSize: 16,)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                              return;
                            }
                          },
                        ),
                      )
                    ],
                  );
                }).toList()
            );
          }
        },
      ),
    );
  }
}
