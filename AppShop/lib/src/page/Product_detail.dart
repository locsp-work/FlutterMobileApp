import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_shop/src/Widget/Screen_navigation.dart';
import 'package:my_shop/src/Widget/bottom_sheet.dart';
import 'package:my_shop/src/Widget/loading.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/model/Products.dart';
import 'package:my_shop/src/page/CartPage.dart';
import 'package:my_shop/src/page/ChatRoom.dart';
import 'package:my_shop/src/provider/app_provider.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:my_shop/src/themes/color_app.dart';
import 'package:my_shop/src/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class buttonSize{
  final String buttonText;
  bool isSelect;
  buttonSize({this.buttonText,this.isSelect=false});
}
class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final bool isLike;
  ProductDetailPage({Key key,this.product,this.isLike}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  ProductModel model;
  bool _isLike;
  bool get isLike=>_isLike;
  bool show = true;
  String sellectSize;
  bool choose=false;


  @override
  void initState() {
    sellectSize='';
    model=widget.product;
    _isLike=widget.isLike;
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: _icon(Icons.arrow_back_ios,
                  color: LightColor.iconColor, size: 15, isOutLine: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon,
      {Color color = LightColor.black,
        double size = 20,
        double padding = 10,
        bool isOutLine = false}) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.black,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 0)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    );
  }

  Widget _productImage() {
    return CarouselSlider(
      height: 310.0,
      viewportFraction: 1.0,
      items: model.image.map((i){
        return Container(
          child: Center(
            child: Image.network(i,fit: BoxFit.fill,),
          ),
        );
      }).toList()
    );
  }
  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      width: AppTheme.fullWidth(context),
      height: 80,
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: 0.7,
      initialChildSize: 0.47,
      minChildSize: 0.47,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: LightColor.background),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.darkgrey,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(width: 200.0,child: Text(model.name, softWrap: true,maxLines: 2,overflow: TextOverflow.ellipsis,)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "\$ ",
                                fontSize: 18,
                                color: LightColor.red,
                              ),
                              TitleText(
                                text: '${model.price-model.price*model.sale/100}',
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "\$ ",
                                fontSize: 12,
                                color: LightColor.grey,
                              ),
                              TitleText(
                                text: model.price.toString(),
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                _description(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TitleText(
          text: "Mô tả",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            '${model.description}',
          ),
        )
//        Text(AppData.description),
      ],
    );
  }

  void _showButton(bool value) {
    setState(() {
      show = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return app.isLoading ? Loading() :MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(),
                  heroTag: null,
                  child: Icon(Icons.message,size: 22,),
                  onPressed: ()async{
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                    Firestore.instance.collection('users')
                      .snapshots().listen((data){
                        print('${data.documents.length}');
                        prefs.setString('FCMToken', data.documents[0]['FCMToken'] ?? 'NOToken');
                        prefs.setString('id', data.documents[0]['id'] ?? '');
                      });
//                    String chatID=makeChatId(user.user.uid, peerID);
                    changeScreen(context,Chat(customerName: user.userModel.name,id:user.userModel.id,peerId: prefs.get('id'), peerAvatar: 'TVKH', productModel: model));
                    },
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
              Expanded(
                flex: 2,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(),
                  child: Icon(Icons.add_shopping_cart,size: 22,),
                  heroTag: null,
                  onPressed: (){
                    var sheetController = showModalBottomSheet(
                        context: context,
                        builder: (context) => BottomSheetWidget(productModel: model,button: 'Thêm vào giỏ hàng',));
                    _showButton(false);
                    sheetController.then((value) {
                      _showButton(true);
                    });
                  },
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
              Expanded(
                flex: 3,
                child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(),
                  child: Text('Mua ngay',style: TextStyle(color: Colors.white),),
                  onPressed: ()async{
                    var sheetController =showModalBottomSheet(
                        context: context,
                        builder: (context) => BottomSheetWidget(productModel: model,button: 'Mua ngay',)).whenComplete(() => changeScreen(context, CartScreen()));
                    },
                ),
              )
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Stack(children:<Widget>[
                      _productImage(),
                      _appBar(),
                    ]),
                    _categoryWidget(),
                  ],
                ),
                _detailWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
