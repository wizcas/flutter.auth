import 'package:auth_demo/pages/login.dart';
import 'package:auth_demo/pages/welcome.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const int _qualiPrimaryColor = 0xFF000000;
const MaterialColor qualiColor = MaterialColor(
  _qualiPrimaryColor,
  <int, Color>{
    50: Color(_qualiPrimaryColor),
    100: Color(_qualiPrimaryColor),
    200: Color(_qualiPrimaryColor),
    300: Color(_qualiPrimaryColor),
    350: Color(
        _qualiPrimaryColor), // only for raised button while pressed in light theme
    400: Color(_qualiPrimaryColor),
    500: Color(_qualiPrimaryColor),
    600: Color(_qualiPrimaryColor),
    700: Color(_qualiPrimaryColor),
    800: Color(_qualiPrimaryColor),
    850: Color(_qualiPrimaryColor), // only for background color in dark theme
    900: Color(_qualiPrimaryColor),
  },
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.grey,
        primarySwatch: qualiColor,
      ),
      routes: {
        'welcome': (BuildContext context) {
          return WelcomePage();
        },
        'login': (BuildContext context) {
          return LoginPage();
        }
      },
      initialRoute: 'welcome',
    );
  }
}
