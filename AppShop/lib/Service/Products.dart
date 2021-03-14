import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/Service/Api.dart';
import 'package:my_shop/src/model/Products.dart';

class ProductServices with ChangeNotifier{
  String collection = "products";
  Firestore _firestore = Firestore.instance;
  Api _api= Api();

  Future<List<ProductModel>> getProducts() async =>
      _api.getDataCollection(collection).then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });
  Future<ProductModel> getProductById(String id)async{
    Firestore.instance.collection(collection).document(id).get().then(
      (value) {
        return ProductModel.fromSnapshot(value);
      });
  }

  void likeOrDislikeProduct({String id, List<String> userLikes}){
    _firestore.collection(collection).document(id).updateData({
      "userLikes": userLikes
    });
  }

  Future<List<ProductModel>> getProductsOfCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .getDocuments()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName;
    return _firestore
        .collection(collection)
        .orderBy("title")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<ProductModel> products = [];
      for (DocumentSnapshot product in result.documents) {
        products.add(ProductModel.fromSnapshot(product));
      }
      return products;
    });
  }
}