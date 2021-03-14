import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardadmin/Services/authentication_service.dart';
import 'package:dashboardadmin/ViewsModel/startup_view_model.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class StartUpView extends StatefulWidget {
  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StartUpViewModel>.withConsumer(
      viewModelBuilder:()=> StartUpViewModel(),
      disposeViewModel: false,
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 100,
                child: Image.asset('assets/images/icon_large.png'),
              ),
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

