import 'package:flutter/material.dart';

String appTitle = 'memo me';
String home = '/';
String settings = '/settings';

double getScreenHeight(BuildContext context) {
  double value = MediaQuery.of(context).size.height;
  return value;
}

double getScreenWidth(BuildContext context) {
  double value = MediaQuery.of(context).size.width;
  return value;
}
