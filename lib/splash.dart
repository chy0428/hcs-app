import 'package:flutter/material.dart';
import 'package:hsc/main.dart';
import 'package:hsc/utils/colors.dart';

import 'login/login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((data) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });

    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              color: mainColor,
            ),
            Image.asset(
              'assets/logoo.png',
              color: mainColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Center(
              child: Image.asset(
                'assets/logoo.png',
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
