import 'package:dashboardadmin/models/post_cat.dart';
import 'package:dashboardadmin/models/post_prod.dart';
import 'package:dashboardadmin/ui/views/create_post_cat_view.dart';
import 'package:dashboardadmin/ui/views/create_post_prod_view.dart';
import 'package:dashboardadmin/ui/views/home_view.dart';
import 'package:dashboardadmin/ui/views/shop_cats_view.dart';
import 'package:flutter/material.dart';
import 'package:dashboardadmin/constants/routes.dart';
import 'package:dashboardadmin/ui/views/login_view.dart';
import 'package:dashboardadmin/ui/views/signup_view.dart';
import 'package:dashboardadmin/ui/views/startup_view.dart';
import 'package:dashboardadmin/ui/views/shop_items_view.dart';
import 'package:dashboardadmin/ui/views/item_reviews_view.dart';
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StartUpView(),
      );
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case CreatePostCatViewRoute:
      var postToEdit = settings.arguments as PostCat;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreatePostCatView(
          edittingPost: postToEdit,
        ),
      );
    case CreatePostProdViewRoute:
      var postToEdit = settings.arguments as PostProd;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreatePostProdView(
          edittingPost: postToEdit,
        ),
      );
    case ShopCatViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ShopCatView(),
      );
    case ShopItemViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ShopItemView(),
      );
    case ShopItemReviewViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ShopItemReviewView(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${settings.name}')),
          ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
