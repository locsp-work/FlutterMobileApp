import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/Service/Api.dart';
import 'package:my_shop/src/model/Category.dart';
import 'package:my_shop/src/model/Products.dart';

enum SearchBy{PRODUCTS, BRAND}
class AppProvider with ChangeNotifier{
//==================================================================//
//================================================================//
  bool isLoading = false;
  SearchBy search = SearchBy.PRODUCTS;
  String filterBy = "products";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;

  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeSearchBy({SearchBy newSearchBy}){
    search = newSearchBy;
    if(newSearchBy == SearchBy.PRODUCTS){
      filterBy = "products";
    }else{
      filterBy = "brands";
    }
    notifyListeners();
  }

  addPrice({int newPrice}){
    priceSum += newPrice;
    notifyListeners();
  }

  addQuantity({int newQuantity}){
    quantitySum += newQuantity;
    notifyListeners();
  }

  getTotalPrice(){
    print("THE TOTAL SUM IS: $priceSum");
    totalPrice = priceSum * quantitySum;
    print("THE TOTAL AMOUNT IS: $totalPrice");
    notifyListeners();
  }
}