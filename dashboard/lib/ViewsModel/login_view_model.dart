import 'package:dashboardadmin/constants/routes.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/Services/authentication_service.dart';
import 'package:dashboardadmin/Services/dialog_service.dart';
import 'package:dashboardadmin/Services/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Lỗi đăng nhập',
          description: 'Đăng nhập sai, vui lòng thử lại',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Lỗi đăng nhập',
        description: result,
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}