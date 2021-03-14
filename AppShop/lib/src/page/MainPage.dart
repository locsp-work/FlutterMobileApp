import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/src/Widget/Screen_navigation.dart';
import 'package:my_shop/src/Widget/loading.dart';
import 'package:my_shop/src/page/CartPage.dart';
import 'package:my_shop/src/page/HomePage.dart';
import 'package:my_shop/src/page/productSearch.dart';
import 'package:my_shop/src/provider/app_provider.dart';
import 'package:my_shop/src/provider/category.dart';
import 'package:my_shop/src/provider/products.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:provider/provider.dart';
class EmptyAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  @override
  Size get preferredSize => Size(0.0,0.0);
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{
  AnimationController _ColoranimationController;
  AnimationController _TextanimationController;
  Animation _colorTween, _iconColorTween;
  Animation<Offset> _transTween;
  @override
  void initState(){
    _ColoranimationController=AnimationController(vsync: this,duration: Duration(seconds: 0));
    _colorTween=ColorTween(begin: Colors.transparent,end: Colors.teal).animate(_ColoranimationController);
    _iconColorTween=ColorTween(begin: Colors.white,end: Colors.black).animate(_ColoranimationController);
    _TextanimationController=AnimationController(vsync: this,duration: Duration(seconds: 0));
    _transTween=Tween(begin: Offset(-10,40),end: Offset(-10,0)).animate(_TextanimationController);
    super.initState();
  }
  bool _scrollListener(ScrollNotification scrollInfo){
    if(scrollInfo.metrics.axis==Axis.vertical){
      _ColoranimationController.animateTo(scrollInfo.metrics.pixels/180);
      _TextanimationController.animateTo(scrollInfo.metrics.pixels/180);
      return true;
    }
  }
  @override
  Widget build(BuildContext context) {
    final app=Provider.of<AppProvider>(context);
    final productProvider=Provider.of<ProductProvider>(context);
    return Status.Authenticating==null ? Loading() : Scaffold(
      primary: true,
      body:SizedBox.expand(
        child: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Container(
            color: Color.fromRGBO(255, 255, 255, 0),
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      MyHomePage(),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  child: AnimatedBuilder(
                    animation: _ColoranimationController,
                    builder: (context,child)=>AppBar(
                      backgroundColor: _colorTween.value,
                      elevation: 0,
                      title: Padding(padding:EdgeInsets.only(left: 20.0),child: Transform.translate(offset: _transTween.value,child: Icon(Icons.home),)),
                      iconTheme: IconThemeData(color: _iconColorTween.value),
                      flexibleSpace:Container(
                        child: Column(
                            children:<Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 60.0,right: 60.0,top: 30.0),
                                child: Material(
                                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                  child: Container(
                                    height: 32,
                                    child: TextField(
                                      onSubmitted: (pattern)async{
                                        app.changeLoading();
                                        if(app.search == SearchBy.PRODUCTS){
                                          await productProvider.search(productName: pattern);
                                          changeScreen(context, ProductSearchScreen());
                                        }
                                      },
                                      cursorColor: Colors.blue,
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        hintText: 'Tìm Kiếm',
                                        hintStyle: TextStyle(color: Colors.black26,fontSize: 12),
                                        prefixIcon: Material(
                                            elevation: 0.0,
                                            borderOnForeground: false,
                                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                            child: IconButton(onPressed: (){},icon: Icon(Icons.search),color: Colors.grey,)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.local_grocery_store,
                          ),
                          onPressed: (){
                            changeScreen(context, CartScreen());
                          },
                        ),
                      ],
                      titleSpacing: 0.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}