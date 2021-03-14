import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/models/user.dart';
import 'package:dashboardadmin/Services/authentication_service.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
