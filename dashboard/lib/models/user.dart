class User{
  final String id;
  final String fullName;
  final String email;
  final String userRole;
  // ignore: non_constant_identifier_names
  final String FCMToken;
  final String chattingWith;

  // ignore: non_constant_identifier_names
  User({this.id, this.fullName, this.email, this.userRole,this.FCMToken,this.chattingWith});
  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'],
        FCMToken= data['FCMToken'],
        chattingWith=data['chattingWith'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
      'FCMToken': FCMToken,
      'chattingWith': ''
    };
  }
}
