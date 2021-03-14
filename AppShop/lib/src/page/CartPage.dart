import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop/Service/Order.dart';
import 'package:my_shop/src/Widget/loading.dart';
import 'package:my_shop/src/Widget/style.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/provider/app_provider.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ScaffoldState>();
    OrderServices _orderServices = OrderServices();
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey.shade100,
      body: app.isLoading ? Loading() : SafeArea(
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
            Expanded(child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: user.userModel.cart.length,
              itemBuilder: (BuildContext context, int index){
                print("THE PRICE IS: ${user.userModel.cart[index]["price"]}");
                print("THE QUANTITY IS: ${user.userModel.cart[index]["quantity"]}");
                return Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        elevation: 3.0,
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 80,
                                child:  Image.network('${user.userModel.cart[index]['image'][0]}'),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TitleText(text: '${user.userModel.cart[index]["name"]}',maxLine: 2,fontSize: 14,),
                                    SizedBox(height: 20.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("đ${ user.userModel.cart[index]["price"]}", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0
                                        ),),
                                        Text("x${ user.userModel.cart[index]["quantity"]}", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0
                                        ),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 15,
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          padding: EdgeInsets.all(0.0),
                          color: Colors.blue,
                          child: Icon(Icons.clear, color: Colors.white,),
                          onPressed: ()async {
                            app.changeLoading();
                            bool value= await user.removeFromCart(cartItem: user.userModel.cart[index]);
                            if(value){
                              user.reloadUserModel();
                              print("Item remove to cart");
                              Fluttertoast.showToast(msg: 'Remove from cart');
                              app.changeLoading();
                              return;
                            }
                            else{
                              print("Item was not removed");
                              app.changeLoading();
                            }
                          },
                        ),
                      ),
                    )
                  ],
                );
              },

            ),),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Text("Cart Subtotal ${user.userModel.totalCartPrice}đ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                  ),),
                  SizedBox(height: 20.0,),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      height: 50.0,
                      color: Colors.lightBlueAccent,
                      child: Text("CheckOut".toUpperCase(), style: TextStyle(
                          color: Colors.white
                      ),),
                      onPressed: (){
                        if(user.userModel.totalCartPrice == 0){
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('Your cart is emty', textAlign: TextAlign.center,),
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
                                        TitleText(text: 'Chấp Nhận Đặt Hàng',fontSize: 25,fontWeight: FontWeight.w900,),
                                        Text('Tổng giá trị đơn hàng ${user.userModel.totalCartPrice}đ', textAlign: TextAlign.center,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 100.0,
                                              child: RaisedButton(
                                                onPressed: () async{
                                                  var uuid = Uuid();
                                                  String id = uuid.v4();
                                                  _orderServices.createOrder(
                                                      userId: user.user.uid,
                                                      id: id,
                                                      status: "Đang chờ",
                                                      totalPrice: user.userModel.totalCartPrice,
                                                      cart: user.userModel.cart
                                                  );
                                                  for(Map cartItem in user.userModel.cart){
                                                    bool value = await user.removeFromCart(cartItem: cartItem);
                                                    if(value){
                                                      user.reloadUserModel();
                                                      print("Item added to cart");
                                                      _key.currentState.showSnackBar(
                                                          SnackBar(content: Text("Removed from Cart!"))
                                                      );
                                                    }else{
                                                      print("ITEM WAS NOT REMOVED");
                                                    }
                                                  }
                                                  _key.currentState.showSnackBar(
                                                      SnackBar(content: Text("Order created!"))
                                                  );
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
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}