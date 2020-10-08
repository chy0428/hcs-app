import 'package:flutter/material.dart';
import 'package:hsc/utils/colors.dart';

class HscAppBarBack extends AppBar {
  final Color backgroundColor = mainColor;
  final double elevation = 0.0;
  final bool centerTitle = true;
  final actions;
  final title;

  HscAppBarBack(
      {this.actions, this.title, Widget leading, BuildContext context})
      : super(
          leading: BackButton(onPressed: () {
            Navigator.pop(context);
          }),
        );
}
