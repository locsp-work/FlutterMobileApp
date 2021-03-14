import 'package:cloud_firestore/cloud_firestore.dart';
class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";
  static const PRICE = "price";
  static const SIZE = "size";


  String _id;
  String _name;
  String _image;
  String _size;
  String _productId;
  int _quantity;
  int _price;




  //  getters
  String get size => _size;

  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  int get price => _price;

  int get quantity => _quantity;


  CartItemModel.fromMap(Map data){
    _id = data[ID];
    _name =  data[NAME];
    _image =  data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _size = data[SIZE];
  }

  Map toMap() => {
    ID: _id,
    IMAGE: _image,
    NAME: _name,
    PRODUCT_ID: _productId,
    QUANTITY: _quantity,
    PRICE: _price,
    SIZE: _size
  };
}