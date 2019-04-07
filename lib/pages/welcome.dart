import 'package:auth_demo/prefabs/intro/fullbg.dart';
import 'package:auth_demo/prefabs/intro/logo.home.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return FullScreenBg(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HomeLogo(),
          RaisedButton(
            child: Text('Sign in'),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
          RaisedButton(
            child: Text('Sign up now!'),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
