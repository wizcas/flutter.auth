import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/la.jpg'),
              fit: BoxFit.cover,
            )),
            // color: Colors.white,
            alignment: Alignment(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: SvgPicture.asset(
                    'assets/images/Quali.svg',
                    color: Colors.white,
                  ),
                ),
                RaisedButton(
                  child: Text('Sign in'),
                  color: Colors.white,
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('Sign up now!'),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
