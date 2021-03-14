import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/src/Widget/title_text.dart';
class OrderInfo extends StatefulWidget {
  final String cartId;
  OrderInfo({this.cartId});
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  String cartId;
  @override
  void initState() {
    cartId=widget.cartId;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> cart=Firestore.instance.collection('orders').document(cartId).snapshots();
    final _key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal:16.0, vertical: 15.0),
                child: Text("CART", style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700
                ),)),
            Expanded(
                child: StreamBuilder(
                  stream: cart,
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                    if(snapshot.connectionState==ConnectionState.active){
                      var cartDoc=snapshot.data.data;
                      var cart=cartDoc['cart'];
                      return ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (BuildContext context,index){
                          return Card(
                            child: InkWell(
                              onTap: (){
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: ListTile(
                                  leading: Image.network(cart[index]['image'][0]),
                                  title: TitleText(text:'${cart[index]['name']}',fontSize: 16,),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      TitleText(text:'${cart[index]['price']}đ',fontSize: 16,),
                                      TitleText(text:'X${cart[index]['quantity']}',fontSize: 16,)
                                    ],
                                  ),
                                )
                              ),
                            ),
                          );
                        },
                      );
                    }else{
                      return Container();
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}