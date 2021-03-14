import 'package:flutter/material.dart';
import 'package:my_shop/Service/Category.dart';
import 'package:my_shop/src/model/Category.dart';

class CategoryProvider with ChangeNotifier{
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];

  CategoryProvider.initialize(){
    loadCategories();
  }

  loadCategories()async{
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }
}