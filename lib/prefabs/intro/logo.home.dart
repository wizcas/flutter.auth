import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeLogo extends StatelessWidget {
  HomeLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'home-logo',
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SvgPicture.asset(
          'assets/images/Quali.svg',
        ),
      ),
    );
  }
}
