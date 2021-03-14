import 'package:flutter/material.dart';
import 'package:my_shop/src/Widget/Screen_navigation.dart';
import 'package:my_shop/src/Widget/loading.dart';
import 'package:my_shop/src/Widget/product_card.dart';
import 'package:my_shop/src/Widget/style.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/model/Category.dart';
import 'package:my_shop/src/page/Product_detail.dart';
import 'package:my_shop/src/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryScreen({Key key, this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      )),
                  ClipRRect(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: categoryModel.image,
                      height: 160,
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
//                    borderRadius: BorderRadius.only(
//                      bottomLeft: Radius.circular(30),
//                      bottomRight: Radius.circular(30),
//                    ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        )),
                  ),
                  Positioned.fill(
                      bottom: 10,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TitleText(text: categoryModel.name, color: white, fontSize: 26, fontWeight: FontWeight.w300,))),
                  Positioned.fill(
                      top: 5,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: black.withOpacity(0.2)
                                ),
                                child: Icon(Icons.close, color: white,)),
                          ),
                        ),)),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (0.6),
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  physics:ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: productProvider.productsByCategory.length,
                  itemBuilder:(BuildContext context, index){
                    return ProductCard(product:productProvider.productsByCategory[index]);
                  }
              ),
            ],

          )),
    );
  }
}