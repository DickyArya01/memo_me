import 'package:flutter/material.dart';

//routes
String appTitle = 'memo me';
String home = '/';
String settings = '/settings';

//constant value
String addTagText = "Tambah Tag";
String addTagHintText = "Masukkan Tag baru";

//device width/height
double getScreenHeight(BuildContext context, double multiple) {
  double value = MediaQuery.of(context).size.height * multiple;
  return value;
}

double getScreenWidth(BuildContext context, double multiple) {
  double value = MediaQuery.of(context).size.width * multiple;
  return value;
}

//constant widget
Widget divider() {
  return Divider(
    height: 2,
    thickness: 2,
    color: black,
  );
}

//color
Color black = Colors.black;
Color red = Colors.red;
