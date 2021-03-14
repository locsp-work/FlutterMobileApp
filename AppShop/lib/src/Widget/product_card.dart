import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:my_shop/src/Widget/style.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/model/Products.dart';
import 'package:my_shop/src/page/Product_detail.dart';
import 'package:my_shop/src/provider/products.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:my_shop/src/themes/color_app.dart';
import 'package:provider/provider.dart';
class ProductCard extends StatefulWidget {
  final ProductModel product;
  ProductCard({Key key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  ProductModel model;
  bool isLike;
  @override
  void initState() {
    isLike=false;
    model = widget.product;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final product=Provider.of<ProductProvider>(context);
    final user=Provider.of<UserProvider>(context);

    return Card(
      elevation: 3,
      child: Hero(
        tag: model.id,
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder:(context)=> ProductDetailPage(product: model,isLike: isLike,)));
            },
            child: Container(
              decoration: BoxDecoration(
                color: LightColor.background,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(child: Image.network(model.image[0],fit: BoxFit.fitWidth,height:180)),
                      // SizedBox(height: 5),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                model.name,
                                style: TextStyle(color: Colors.black45),
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                TitleText(text:'đ${model.price}',
                                  fontSize:12,color: grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: TitleText(
                                      text: 'đ${(model.price-(model.price*(model.sale/100))).round()}',
                                      fontSize: 16,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
//                  IconButton(
//                      icon: Icon(isLike ? Icons.favorite : Icons.favorite_border, color:isLike ? LightColor.red : LightColor.grey,),
//                      onPressed: (){
//                        setState(() {
//                          isLike = !isLike;
//                        });
//                        product.likeDislikeProduct(userId: user.user.uid,product: model,liked: isLike);
//                      }),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: PointsClipper(),
                      child: Container(color:Colors.yellowAccent,height:30.0,child: Text('-${model.sale}%',style: TextStyle(color: Colors.redAccent),),)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
