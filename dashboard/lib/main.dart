import 'package:dashboardadmin/ui/views/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:dashboardadmin/Services/navigation_service.dart';
import 'package:dashboardadmin/Services/dialog_service.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Color(0xff19c7c1),
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Open Sans',
        ),
      ),
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}