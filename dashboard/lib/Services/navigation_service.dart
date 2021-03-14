import 'package:flutter/services.dart';
import 'package:dashboardadmin/Services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:dashboardadmin/locator.dart';
class NavigationService {
  DateTime currentBackPressTime;
  DialogService _dialogService=locator<DialogService>();
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;
  Future<bool> poppushNamedAndRemoveUntil(String goto){
    _navigationKey.currentState.pushNamedAndRemoveUntil(goto, (Route<dynamic> route) => false);
  }
  Future<bool> pushNamedAndRemoveUntil(String context,String goto){
    _navigationKey.currentState.pushNamedAndRemoveUntil(context, ModalRoute.withName(goto));
  }
  Future<bool> popUntil(String route){
    _navigationKey.currentState.popUntil(ModalRoute.withName(route));
  }
  Future<bool> pushReplacementNamed(String route){
    _navigationKey.currentState.pushReplacementNamed(route);
  }
  Future<bool> popAndPushNamed(String route){
    _navigationKey.currentState.popAndPushNamed(route);
  }
  Future<bool> pop(){
    _navigationKey.currentState.pop();
  }
  Future<bool> ExitApp(BuildContext context){
    return showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text('Do you want to exit the app?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: ()=>Navigator.pop(context,false),
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed:()=>SystemNavigator.pop(),
          ),
        ],
      )
    );
  }
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState.pushNamed(routeName, arguments: arguments);
  }
}
