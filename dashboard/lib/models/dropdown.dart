import 'dart:collection';
import 'package:flutter/widgets.dart';
class DropdownProvider with ChangeNotifier{
  List<String> _item=[];
  String _selectedItem;
  set item(List<String> i) =>_item.addAll(i);
  List<String> get item=>_item;
    UnmodifiableListView<String> get items {
      return UnmodifiableListView(_item);
    }
    String get selectedItem=>_selectedItem;
    set selectedItem(String s){
      _selectedItem=s;
      notifyListeners();
    }
  }
