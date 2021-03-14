import 'package:flutter/foundation.dart';

class PostProd {
  String title;
  List<String> imageUrl;
  final String userId;
  String detail;
  List<String> imageFileName;
  final String documentId;
  String categories;
  int quantity;
  String size;
  int price;
  int sale;
  PostProd({
    @required this.userId,
    @required this.title,
    this.documentId,
    this.imageFileName,
    this.imageUrl,
    this.detail,
    this.categories,
    this.quantity,
    this.size,
    this.price,
    this.sale
  }
  );

  Map<String, dynamic> toMap() =>{
      'userId': userId,
      'title': title,
      'imageUrl': List.from(imageUrl),
      'imageFileName': List.from(imageFileName),
      'detail': detail,
      'category': categories,
      'quantity': quantity,
      'size': size,
      'price': price,
      'sale': sale,

  };

  static PostProd fromMap(Map<dynamic, dynamic> map, String documentId) {
    if (map == null) return null;
    return PostProd(
      title: map['title'],
      imageUrl: List.from(map['imageUrl']),
      userId: map['userId'],
      detail: map['detail'],
      imageFileName: List.from(map['imageFileName']),
      documentId: documentId,
      categories: map['category'],
      quantity: map['quantity'],
      size: map['size'],
      price: map['price'],
      sale: map['sale']
    );
  }
}
