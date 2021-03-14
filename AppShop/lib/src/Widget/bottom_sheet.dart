import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop/src/Widget/Screen_navigation.dart';
import 'package:my_shop/src/Widget/style.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/model/Products.dart';
import 'package:my_shop/src/page/CartPage.dart';
import 'package:my_shop/src/provider/app_provider.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:provider/provider.dart';

class BottomSheetWidget extends StatefulWidget {
  final ProductModel productModel;
  final String button;
  const BottomSheetWidget({Key key,this.productModel,this.button}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}
class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  bool close=false;
  ProductModel _model;
  bool sizeM=false;
  bool sizeX=false;
  bool sizeS=false;
  bool sizeL=false;
  int quantity = 1;
  bool checkingFlight = false;
  bool _success = false;
  bool get success =>_success;
  String _titleButton;
  @override
  void initState() {
    _model=widget.productModel;
    _titleButton=widget.button;
    super.initState();
  }
  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Chọn Size",
          fontSize: 14,
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('M'),
            Checkbox(
                activeColor: Colors.blue,
                value: sizeM,
                onChanged:_model.size.contains('M') ? (bool value){
                  setState(() {
                    sizeM=value;
                    sizeL=false;
                    sizeS=false;
                    sizeX=false;
                  });
                }: null
            ),
            SizedBox(width: 10,),
            Text('S'),
            Checkbox(
                value: sizeS,
                onChanged:_model.size.contains('S') ? (bool value){
                  setState(() {
                    sizeM=false;
                    sizeL=false;
                    sizeS=value;
                    sizeX=false;
                  });
                }: null
            ),
            SizedBox(width: 10,),
            Text('X'),
            Checkbox(
                value: sizeX,
                onChanged:_model.size.contains('X') ? (bool value){
                  setState(() {
                    sizeM=false;
                    sizeL=false;
                    sizeS=false;
                    sizeX=value;
                  });
                }: null
            ),
            SizedBox(width: 10,),
            Text('L'),
            Checkbox(
                value: sizeL,
                onChanged:_model.size.contains('L') ? (bool value){
                  setState(() {
                    sizeM=false;
                    sizeL=value;
                    sizeS=false;
                    sizeX=false;
                  });
                }: null
            ),
            SizedBox(width: 10,)

          ],
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
                  ]),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: 10) ,
                          child: Image.network(
                              '${_model?.image[0] ?? ''}'
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text('${_model.price-(_model.price*(_model.sale/100))}'),
                            Text('Kho: ${_model.quantity}')
                          ],
                        )
                      ],
                      )
                    ),
                      _availableSize(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TitleText(text: 'Số lượng',fontSize: 14,),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    if(quantity != 1){
                                      setState(() {
                                        quantity -= 1;
                                      });
                                    }
                                  },
                                  child: Container(color:Colors.lightBlueAccent,child: Icon(Icons.remove,size: 20,color: Colors.white,)),
                                ),
                              ),
                              Text(quantity.toString()),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    if(quantity<_model.quantity){
                                      setState(() {
                                        quantity += 1;
                                      });
                                    }
                                  },
                                  child: Container(color:Colors.red,child: Icon(Icons.add,size: 20,color: white,)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  !checkingFlight
                      ? MaterialButton(
                    height: 30,
                    color: Colors.grey[800],
                    onPressed: () async {
                      app.changeLoading();
                      print("All set loading");
                      bool value =  await user.addToCard(product: _model, quantity: quantity);
                      if(value){
                        print("Item added to cart");
                        Fluttertoast.showToast(msg: 'Sản phẩm đã được thêm vào giỏ hàng');
                        user.reloadUserModel();
                        app.changeLoading();
                        return;
                      } else{
                        print("Item NOT added to cart");

                      }
                      setState(() {
                        checkingFlight = true;
                      });
                      await Future.delayed(Duration(seconds:1));
                      setState(() {
                        _success = true;
                      });
                      await Future.delayed(Duration(milliseconds: 500));
                      Navigator.pop(context);
                    },
                    child: Text(
                      '$_titleButton',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                      : !_success
                      ? CircularProgressIndicator()
                      : Icon(Icons.check, color: Colors.green,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
