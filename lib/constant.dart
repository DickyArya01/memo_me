import 'dart:math';

import 'package:flutter/material.dart';

import 'data/data.dart';

//routes
String appTitle = 'memo me';
String home = '/';
String settings = '/settings';
String calendar = '/calendar';
String note = '/note';
String editnote = '/editnote';

//constant value
String addTagText = "Tambah Tag";
String addTagHintText = "Masukkan Tag baru";
String edit = "Edit";
String refresh = "refresh";

Tag getTag(String uid) {
  List<Tag> listTagbyUid =
      listTag.where((element) => element.uid == uid).toList();

  return listTagbyUid[0];
}

void navigateToPageWithTagContent(BuildContext context, String routeName, TagContent content) {
  Navigator.of(context).pushNamed(routeName, arguments: TagContent(title: content.title, content: content.content, createdTime: content.createdTime, reminderTime: content.reminderTime, uid: content.uid));
}

void popPage(BuildContext context) {
  Navigator.of(context).pop();
}

String randomNumber() {
  Random random = Random();

  double number = random.nextDouble() * 1000000;

  while (number < 100000) {
    number *= 10;
  }

  String numberToString = number.toString();
  numberToString = numberToString.replaceAll(RegExp('[^0-9]'), '');
  return numberToString;
}

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
Color white = Colors.white;
Color red = Colors.red;
