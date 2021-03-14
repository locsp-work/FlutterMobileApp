import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_shop/src/model/Cart_item.dart';

class UserModel{
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";
  static const CHATTING= "chattingWith";


  String _name;
  String _email;
  String _id;
  int _priceSum = 0;


//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;

//  public variable
  List cart;
  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    cart = snapshot.data[CART] ?? [];
    totalCartPrice = snapshot.data[CART] == null ? 0 :getTotalPrice(cart: snapshot.data[CART]);
  }

  int getTotalPrice({List cart}){
    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }

    int total = _priceSum;

    print("THE TOTAL IS $total");

    return total;
  }
}