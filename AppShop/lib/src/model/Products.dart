import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const NAME = "title";
  static const RATING = "rating";
  static const IMAGE = "imageUrl";
  static const PRICE = "price";
  static const DESCRIPTION = "detail";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const USER_LIKES = "userLikes";
  static const  QUANTITY = "quantity";
  static const SIZE='size';
  static const SALE='sale';

  String _id;
  String _name;
  String _category;
  List<dynamic> _image;
  String _description;
  double _rating;
  int _price;
  bool _featured;
  int _quantity;
  String _size;
  int _sale;
  List<dynamic> _userLikes;

  String get id => _id;

  String get name => _name;

  String get category =>_category;

  String get description => _description;

  List<dynamic> get image => List.of(_image);

  double get rating => _rating;

  int get price => _price;

  bool get featured => _featured;

  int get quantity => _quantity;

  String get size => _size;

  int get sale => _sale;

  List<dynamic> get userLikes=> List.of(_userLikes);

  bool liked = false;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot):
    _id = snapshot.documentID ?? '',
    _name= snapshot[NAME] ?? '',
    _category = snapshot[CATEGORY] ?? '',
    _image= snapshot[IMAGE] ?? [],
    _price= snapshot[PRICE] ?? '',
    _quantity= snapshot[QUANTITY] ?? '',
    _size= snapshot[SIZE] ?? '',
    _sale= snapshot[SALE] ?? '',
    _description = snapshot[DESCRIPTION] ?? '',
    _userLikes = snapshot[USER_LIKES] ?? [];
}