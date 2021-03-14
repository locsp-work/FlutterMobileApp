import 'package:flutter/material.dart';
import 'package:my_shop/src/Widget/bottom_nav.dart';
import 'package:my_shop/src/Widget/loading.dart';
import 'package:my_shop/src/provider/app_provider.dart';
import 'package:my_shop/src/provider/category.dart';
import 'package:my_shop/src/provider/products.dart';
import 'package:my_shop/src/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'src/page/LoginPage.dart';
void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}
class ScreensController extends StatefulWidget {
  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginPage();
      case Status.Authenticated:
        return BottomNav(currentUserId: auth.user.uid,);
      default:
        return LoginPage();
    }
  }
}

