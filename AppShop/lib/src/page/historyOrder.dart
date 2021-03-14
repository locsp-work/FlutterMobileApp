import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_shop/src/Widget/Screen_navigation.dart';
import 'package:my_shop/src/Widget/loading.dart';
import 'package:my_shop/src/page/OrderInfo.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:provider/provider.dart';
class HistoryOrder extends StatefulWidget {
  @override
  _HistoryOrderState createState() => _HistoryOrderState();
}

class _HistoryOrderState extends State<HistoryOrder> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context);
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('orders').where('userId',isEqualTo: user.user.uid).where('status', isEqualTo: 'Đã giao').snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Loading();
          }else{
            return ListView(
                children:snapshot.data.documents.map((DocumentSnapshot document){
                  return Card(
                    child:InkWell(
                      onTap: (){
                        changeScreen(context, OrderInfo(cartId: document['id'],));
                      },
                      child: Container(
                          height: 80.0,
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
                  );
                }).toList()
            );
          }
        },
      ),
    );
  }
}
