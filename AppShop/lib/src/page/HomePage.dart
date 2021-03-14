import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/src/Widget/image_carousel.dart';
import 'package:my_shop/src/Widget/product_card.dart';
import 'package:my_shop/src/Widget/category_card.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/provider/products.dart';
import 'package:my_shop/src/provider/category.dart';
import 'package:my_shop/src/themes/color_app.dart';
import 'package:my_shop/src/themes/theme.dart';
import 'package:provider/provider.dart';
@override
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Column(
      children: <Widget>[
        image_carousel(),
        Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: LightColor.background,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 5),child: TitleText(text:'Danh mục', fontSize: 12,)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: AppTheme.fullWidth(context),
                  height: 140,
                  child: Container(
                    decoration: BoxDecoration(
                      color: LightColor.background,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryProvider.categories.length,
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                            child: CategoryItem(category: categoryProvider.categories[index],)
                        );
                      },
                    ),
                  )
                ),
              ],
          ),
        ),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (0.6),
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
            physics:ScrollPhysics(),
            shrinkWrap: true,
            itemCount: productProvider.products.length,
            itemBuilder:(BuildContext context, index){
              return ProductCard(product:productProvider.products[index]);
            }
        ),


      ],
    );
  }
}
