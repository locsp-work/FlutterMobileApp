import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardadmin/Services/firestore_service.dart';
import 'package:dashboardadmin/models/post_prod.dart';
import 'package:dashboardadmin/ui/views/CartPage.dart';
import 'package:dashboardadmin/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../locator.dart';
class OrderCheck extends StatefulWidget {
  @override
  _OrderCheckState createState() => _OrderCheckState();
}

class _OrderCheckState extends State<OrderCheck> {
  FirestoreService firestoreService=locator<FirestoreService>();
  String status;
  @override
  void initState() {
    status='Đang chờ';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('orders').snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Loading();
          }else{
            return ListView(
              children:snapshot.data.documents.map((DocumentSnapshot document){
                return Card(
                  child:InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderInfo(cartId: document['id'])));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Row(
                        children: <Widget>[
                          Text('${document['status']}'),
                          Column(
                            children: <Widget>[
                              Text('ID đơn hàng: ${document['id']}',style: TextStyle(fontSize: 10),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                children: <Widget>[
                                  Text('Giá: ${document['total']}'),
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                          icon: Icon(Icons.check_box),
                                          onPressed: (){
                                            if(document['status']=='Đang chờ')
                                              Firestore.instance.collection('orders').document(document['id']).updateData({
                                                'status': 'Xác nhận'
                                              });
                                          }
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.train),
                                          onPressed: (){
                                            if(document['status']=='Xác nhận')
                                              Firestore.instance.collection('orders').document(document['id']).updateData({
                                                'status': 'Vận chuyển'
                                              });
                                          }
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.assignment_turned_in),
                                          onPressed: (){
                                            if(document['status']=='Vận chuyển')
                                              Firestore.instance.collection('orders').document(document['id']).updateData({
                                                'status': 'Đã giao'
                                              });
                                          }
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
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
