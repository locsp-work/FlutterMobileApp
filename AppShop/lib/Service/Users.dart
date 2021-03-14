import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_shop/src/model/Users.dart';

class UserServices{
  String collection = "Customers";
  Firestore _firestore = Firestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updateUserData(Map<String, dynamic> values){
    _firestore.collection(collection).document(values['id']).updateData(values);
  }

  void likeOrDislikeProduct({String id, List<String> productId}){
    _firestore.collection(collection).document(id).updateData({
      "likedProduct": productId
    });
  }

  void addToCart({String userId, Map cartItem}){
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayUnion([cartItem])
    });
  }

  void removeFromCart({String userId, Map cartItem}){
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayRemove([cartItem])
    });
  }


  Future<UserModel> getUserById(String id) => _firestore.collection(collection).document(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });
}