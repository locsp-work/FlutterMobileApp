import 'package:flutter/material.dart';
import 'package:my_shop/src/Widget/title_text.dart';
import 'package:my_shop/src/model/Category.dart';
import 'package:my_shop/src/page/CategoryPage.dart';
import 'package:my_shop/src/provider/products.dart';
import 'package:provider/provider.dart';

import 'Screen_navigation.dart';
class CategoryItem extends StatefulWidget {
  final CategoryModel category;
  CategoryItem({this.category,Key key}) : super(key:key);
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  CategoryModel model;
  @override
  void initState() {
    model=widget.category;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final productProvider= Provider.of<ProductProvider>(context);
    return Container(
          height: 140.0,
          width: 100.0,
          child: InkWell(
            onTap: ()async{
              await productProvider.loadProductsByCategory(categoryName:model.name);
              changeScreen(context, CategoryScreen(categoryModel: model,));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                model.image != null ? Image.network(model.image,height: 100,width: 100,fit: BoxFit.fill,) : SizedBox(),
                model.name == null ? Container()
                    : TitleText(text:'${model.name}',fontSize: 12,fontWeight: FontWeight.w600,),

              ],
            ),
          ),
        );
  }
}

