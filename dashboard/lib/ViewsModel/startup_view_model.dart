import 'package:dashboardadmin/constants/routes.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/Services/authentication_service.dart';
import 'package:dashboardadmin/Services/navigation_service.dart';
import 'package:dashboardadmin/ViewsModel/base_model.dart';
import 'dart:async';
class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic()async{
    Timer(Duration(seconds: 3),()async
      {
        var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
        if (hasLoggedInUser) {
          _authenticationService.getUserIsLogged();
          _navigationService.navigateTo(HomeViewRoute);
        } else {
          _navigationService.navigateTo(LoginViewRoute);
        }
      }
    );
  }
}
