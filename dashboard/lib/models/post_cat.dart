import 'package:flutter/foundation.dart';

class PostCat {
  String title;
  String imageUrl;
  final String userId;
  String detail;
  String imageFileName;
  final String documentId;
  PostCat({
    @required this.userId,
    @required this.title,
    this.documentId,
    this.imageFileName,
    this.imageUrl,
    this.detail,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
      'detail': detail,
    };
  }

  static PostCat fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;
    return PostCat(
      title: map['title'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      detail: map['detail'],
      imageFileName: map['imageFileName'],
      documentId: documentId,
    );
  }
}
