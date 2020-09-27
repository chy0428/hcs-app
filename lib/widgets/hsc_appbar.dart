import 'package:flutter/material.dart';
import 'package:hsc/utils/colors.dart';

class HscAppBar extends AppBar {
  final Color backgroundColor = mainColor;
  final double elevation = 0.0;
  final bool centerTitle = true;
  final title;
  final actions;

  HscAppBar({this.title, this.actions, Widget leading, BuildContext context})
      : super();
}
