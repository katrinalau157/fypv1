import 'package:flutter/material.dart';
import 'package:fypv1/MainScaffold.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'helpers/Constants.dart';

import 'login.dart';
import 'MainScaffold.dart';
import 'takephoto.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  final routes = <String, WidgetBuilder>{
    loginPageTag: (context) => loginPage(),
    mainScaffoldTag:(context) => MainScaffold(),
    takePhotoPageTag:(context) => takePhotoPage(),
  };

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: loginPage(), //LoginPage(), // just added
        routes: routes);
  }
}
