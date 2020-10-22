import 'package:appetit_app/pages/page_login.dart';
import 'package:appetit_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appetit',
      theme: ThemeData(
        fontFamily: 'Open Sans',
        brightness: Brightness.light,
        primaryColor: Constants.primary_color,
        scaffoldBackgroundColor: Constants.background,
      ),
      home: LoginPage(),
    );
  }
}
