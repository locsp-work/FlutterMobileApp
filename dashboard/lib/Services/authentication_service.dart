import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firestore_service.dart';
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  User _currentUser;
  User get currentUser => _currentUser;
  SharedPreferences _preferences;
  SharedPreferences get preferences=>_preferences;
  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      _preferences=await SharedPreferences.getInstance();
      _preferences.setBool('isLoggedIn', true);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String role,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = User(
        id: authResult.user.uid,
        email: email,
        fullName: fullName,
        userRole: role,
        FCMToken: prefs.get('FCMToken') ?? 'NOToken',
        chattingWith: '',
      );
      await _firestoreService.createUser(_currentUser);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }
  Future<bool> signOut() async{
    await _firebaseAuth.signOut();
    _preferences=await SharedPreferences.getInstance();
    _preferences?.clear();
    return true;
  }

  Future<bool> isUserLoggedIn() async {
    _preferences=await SharedPreferences.getInstance();
    var status=preferences.getBool('isLoggedIn') ?? false;
    return status;
  }
  Future<User> getUserIsLogged() async{
    return _currentUser=await _firestoreService.getUser(_preferences.getString('uid'));
  }
  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null){
      _currentUser = await _firestoreService.getUser(user.uid);
      _preferences = await SharedPreferences.getInstance();
      _preferences.setString('name', _currentUser.fullName);
      _preferences.setString('email', currentUser.email);
      _preferences.setString('uid',_currentUser.id);
    }
  }
}
