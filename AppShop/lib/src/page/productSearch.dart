import 'package:flutter/material.dart';
import 'package:my_shop/src/Widget/Screen_navigation.dart';
import 'package:my_shop/src/Widget/product_card.dart';
import 'package:my_shop/src/Widget/style.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/page/Product_detail.dart';
import 'package:my_shop/src/provider/products.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        }),
        title: TitleText(text: "Products", fontSize: 20,),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){})
        ],
      ),
      body: productProvider.productsSearched.length < 1? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.search, color: grey, size: 30,),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleText(text: "No products Found", color: grey, fontWeight: FontWeight.w300, fontSize: 22,),
            ],
          )
        ],
      ) : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (0.6),
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5),
          physics:ScrollPhysics(),
          shrinkWrap: true,
          itemCount: productProvider.productsSearched.length,
          itemBuilder:(BuildContext context, index){
            return ProductCard(product:productProvider.productsSearched[index]);
          }
      ),
    );
  }
}