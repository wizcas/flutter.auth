import 'package:flutter/material.dart';

class FullScreenBg extends StatelessWidget {
  static const DefaultBg = 'assets/images/easter.jpg';
  final String bgImg;
  final Widget child;

  FullScreenBg({Key key, this.child, this.bgImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(bgImg == null ? DefaultBg : bgImg),
        fit: BoxFit.cover,
      )),
      alignment: Alignment(0, 0),
      child: child,
    ));
  }
}
