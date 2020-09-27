import 'package:flutter/material.dart';
import 'package:hsc/splash.dart';

main() {
  runApp(App());
}

// TODO: Convert ShrineApp to stateful widget (104)
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSC',
      home: SplashScreen(),
      // TODO: Add a theme (103)
    );
  }
}

//done
