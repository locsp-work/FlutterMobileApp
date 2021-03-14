import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboardadmin/models/post_cat.dart';
import 'package:flutter/material.dart';

class PostCatItem extends StatelessWidget {
  final PostCat post;
  final Function onDeleteItem;
  const PostCatItem({Key key, this.post, this.onDeleteItem,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 70,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: <Widget>[
          post.imageUrl!=null ?
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: Colors.blue.shade300),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(post.imageUrl),
                  fit: BoxFit.fill
                ),
              )
            )
          : Container(),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(post.title),
          )),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              if (onDeleteItem != null) {
                onDeleteItem();
              }
            },
          ),
        ],
      ),
    );
  }
}
