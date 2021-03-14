import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CONTACT = "phone";
  static const ADDRESS= "address";
  static const CREATED_AT = "createdAt";

  String _id;
  String _userId;
  String _status;
  int _createdAt;
  int _total;


//  getters
  String get id => _id;

  String get userId => _userId;

  String get status => _status;

  int get total => _total;

  int get createdAt => _createdAt;

  // public variable
  List cart;
  int phone;
  int address;


  OrderModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _total = snapshot.data[TOTAL];
    _status = snapshot.data[STATUS];
    _userId = snapshot.data[USER_ID];
    _createdAt = snapshot.data[CREATED_AT];
    cart = snapshot.data[CART];
    phone = snapshot.data[CONTACT];
    address = snapshot.data[ADDRESS];
  }
}