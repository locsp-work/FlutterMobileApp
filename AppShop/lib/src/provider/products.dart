import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/Service/Api.dart';
import 'package:my_shop/Service/Products.dart';
import 'package:my_shop/src/model/Products.dart';
class ProductProvider with ChangeNotifier{
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  ProductModel productModel;
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsSearched = [];
  String collection='products';
  Api _api=Api();

  ProductProvider.initialize(){
    loadProducts();
  }

  loadProducts()async{
    products = await _productServices.getProducts();
    notifyListeners();
  }
  Stream<QuerySnapshot> loadProductsAsStream() {
    notifyListeners();
    return _api.streamDataCollection(collection);
  }

  loadProductsById(String id)async{
    productModel=await _productServices.getProductById(id);
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName})async{
    productsByCategory = await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }


  likeDislikeProduct({String userId, ProductModel product, bool liked})async{
    if(liked){
      product.userLikes.add(userId);
      _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
    }else{
      if(product.userLikes.remove(userId)){
        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
      }else{
        print("THE USER WAS NOT REMOVED");
      }
    }
  }
  Future search({String productName})async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
    notifyListeners();
  }


}