import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardadmin/Services/authentication_service.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/ui/widgets/const.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ChatRoom.dart';

class ChatList extends StatefulWidget {
  ChatList(this.myID, this.myName);
  String myID;
  String myName;

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  String id;
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat App - Chat List'),
          centerTitle: true,
        ),
        body:  Stack(
          children: <Widget>[
            // List
            Container(
              child: StreamBuilder(
                stream: Firestore.instance.collection('Customers').where('chattedWith', arrayContains: _authenticationService.currentUser.id).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) => buildItem(context, snapshot.data.documents[index]),
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Material(
              child:  document['name']!= null
                  ? AvatarGlow(
                    child: Text('${document['name']}'),
                    endRadius: 30)
                  : Icon(
                Icons.account_circle,
                size: 50.0,
                color: greyColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              clipBehavior: Clip.hardEdge,
            ),
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Customer: ${document['name']}',
                        style: TextStyle(color: primaryColor),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    Container(
                      child: Text(
                        '${document['email'] ?? 'Not available'}',
                        style: TextStyle(color: primaryColor),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 20.0),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat(
                    id: _authenticationService.currentUser.id,
                    peerId: document['id'],
                    peerAvatar: document['name'],
                  )));
        },
        color: greyColor2,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
    );

  }
}