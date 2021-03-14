import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_shop/src/Widget/bottom_nav.dart';
import 'package:my_shop/src/Widget/loading.dart';
import 'package:my_shop/src/provider/category.dart';
import 'package:my_shop/src/provider/products.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:my_shop/src/Widget/customText.dart';
import 'package:my_shop/src/Widget/style.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/src/Widget/Screen_navigation.dart';

import 'LoginPage.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status==Status.Authenticating ? Loading() : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80.0),
            Stack(
              children: <Widget>[
                Positioned(
                  left: 20.0,
                  top: 15.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20.0)),
                    width: 70.0,
                    height: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    "Sign Up",
                    style:
                    TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextFormField(
                  controller: authProvider.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Username",
                      icon: Icon(Icons.person)
                  ),
                )
            ),
            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child:TextFormField(
                  controller: authProvider.email,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      icon: Icon(Icons.email)
                  ),
                )
            ),
            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextFormField(
                  controller: authProvider.password,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      icon: Icon(Icons.lock)
                  ),
                )
            ),
            const SizedBox(height: 60.0),
            Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                color: Colors.yellow,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0))),
                onPressed: () async{
                  if(!await authProvider.signUp()){
                    _key.currentState.showSnackBar(
                        SnackBar(content: Text("Resgistration failed!"))
                    );
                    return;
                  }
                  categoryProvider.loadCategories();
                  productProvider.loadProducts();
                  authProvider.clearController();
                  changeScreenReplacement(context, BottomNav());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Sign up".toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    const SizedBox(width: 40.0),
                    Icon(
                      FontAwesomeIcons.arrowRight,
                      size: 18.0,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                changeScreen(context, LoginPage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(text: "Login here", size: 12,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
