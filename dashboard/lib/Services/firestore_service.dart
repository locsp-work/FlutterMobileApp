import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardadmin/models/post_cat.dart';
import 'package:dashboardadmin/models/post_prod.dart';
import 'package:dashboardadmin/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
class FirestoreService{
  final CollectionReference _usersCollectionReference = Firestore.instance.collection('users');
  final CollectionReference _postsCatCollectionRef = Firestore.instance.collection('categories');
  final CollectionReference _postsItemCollectionRef =Firestore.instance.collection('products');
  final StreamController<List<PostCat>> _postsCatController = StreamController<List<PostCat>>.broadcast();
  final StreamController<List<PostProd>> _postsProdController = StreamController<List<PostProd>>.broadcast();
//-----------------------------------Login User--------------------------------------------//

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
//-----------------------------------Post--------------------------------------------//

  Future addPostCat(PostCat post) async {
    try {
      await _postsCatCollectionRef.add(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
  Future addPostProd(PostProd post) async{
      try{
        await _postsItemCollectionRef.add(post.toMap());
      } catch (e) {
        if (e is PlatformException) {
          return e.message;
        }
        return e.toString();
      }
    }

  Stream listenToPostsRealTime(String tab) {
    if(tab=='categories'){
      _postsCatCollectionRef.snapshots().listen((postsSnapshot) {
        if (postsSnapshot.documents.isNotEmpty) {
          var posts = postsSnapshot.documents
              .map((snapshot) => PostCat.fromMap(snapshot.data, snapshot.documentID))
              .where((mappedItem) => mappedItem.title != null)
              .toList();
          _postsCatController.add(posts);
        }
      });
      return _postsCatController.stream;
    }else if(tab=='products'){
      _postsItemCollectionRef.snapshots().listen((postsSnapshot) {
        if (postsSnapshot.documents.isNotEmpty) {
          var posts = postsSnapshot.documents
              .map((snapshot) => PostProd.fromMap(snapshot.data, snapshot.documentID))
              .where((mappedItem) => mappedItem.title != null).toList();
          _postsProdController.add(posts);
        }
      });
      return _postsProdController.stream;
    }
  }

  Future deletePost(String documentId,String tab) async {
    if(tab=='categories') {
      await _postsCatCollectionRef.document(documentId).delete();
    }
    else if(tab=='products'){
      await _postsItemCollectionRef.document(documentId).delete();
    }
  }
  Future updatePostCat(PostCat post) async {
    try {
      await _postsCatCollectionRef
          .document(post.documentId)
          .updateData(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future updatePostProd(PostProd post) async{

    try {
      await _postsItemCollectionRef
          .document(post.documentId)
          .updateData(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
//-----------------------------------Products post--------------------------------------------//
