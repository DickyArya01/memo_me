import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/intl.dart';
import 'package:memo_me/data/data.dart';
import 'package:memo_me/constant.dart';
import 'package:memo_me/database/memo_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  DateFormat dateFormat = DateFormat('d-MM-yyyy');
  DateFormat timeFormat = DateFormat.Hm();

  List _list = [];
  List _listAll = [];
  String uid = "";

  void initState() {
    // TODO: implement initState
    initialization();
    refreshTag();
    refreshTagContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, settings),
              icon: Icon(Icons.settings))
        ],
      ),
      drawer: drawerView(),
      body: bodyView(),
      floatingActionButton: actionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget drawerView() {
    return Container(
      width: getScreenWidth(context, 0.8),
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text("Drawer Header"),
            ),
            addTagFun(),
            listOfTag(),
          ],
        ),
      ),
    );
  }

  Future refreshTagContent() async {
    listTagContent = await MemoDatabase.instance.readAllTagContent();

    List listTemp =
        listTagContent.where((element) => element.uid == uid).toList();

    setState(() {
      _list = listTemp;
    });
  }

  Future refreshTag() async {
    List<Tag> listTemp = await MemoDatabase.instance.readAllTag();
    setState(() {
      listTag = listTemp;
    });
  }

  Future submitTag(String tag) async {
    bool isDuplicate;

    String uid = randomNumber();

    for (var element in listTag) {
      if (element.uid == randomNumber()) {
        isDuplicate = true;
        uid = randomNumber();
      }
    }

    await MemoDatabase.instance.insertTag(Tag(tag: tag, uid: uid));
    refreshTag();
  }

  Widget actionButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          fab(Icons.calendar_month, calendar, calendar),
          centerfab(),
          fab(Icons.refresh, refresh, refresh),
        ],
      ),
    );
  }

  Widget fab(IconData iconData, String routeName, String _heroTag) {
    return FloatingActionButton(
        heroTag: _heroTag,
        backgroundColor: white,
        child: Icon(iconData, color: black),
        onPressed: () {
          switch (routeName) {
            case "refresh":
              setState(() {
                _list = listTagContent
                    .where((element) => element.uid == uid)
                    .toList();
              });
              break;
            case "/calendar":
              Navigator.of(context).pushNamed(routeName);
              break;
            default:
          }
        });
  }

  Widget centerfab() {
    return SizedBox(
      height: 72,
      width: 72,
      child: FittedBox(
        child: FloatingActionButton(
            heroTag: note,
            child: const Icon(Icons.add, size: 38),
            onPressed: () {
              if (uid == "") {
              } else {
                Tag tag = getTag(uid);
                Navigator.of(context)
                    .pushNamed(editnote,
                        arguments: Tag(id: tag.id, tag: tag.tag, uid: tag.uid))
                    .then((value) => refreshTagContent());
              }
            }),
      ),
    );
  }

  Widget listOfTag() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: listTag.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(right: 8, bottom: 8),
              padding: const EdgeInsets.only(left: 16),
              height: 48,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.bookmark),
                  ),
                  Text(listTag[index].tag)
                ],
              ),
            ),
            onTap: () {
              setState(() {
                uid = listTag[index].uid;
                refreshTagContent();
                popPage(context);
              });
            },
          );
        },
      ),
    );
  }

  Widget addTagFun() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.bookmark_add),
                  ),
                  Text(addTagText),
                ],
              ),
              IconButton(
                  onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Tambahkan Tag"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Form(
                                  child: Column(
                                children: [
                                  TextField(
                                    controller: _controller,
                                    autocorrect: true,
                                    autofocus: false,
                                    enableInteractiveSelection: true,
                                    decoration: InputDecoration(
                                        hintText: addTagHintText),
                                    onSubmitted: (value) {
                                      submitTag(value);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        submitTag(_controller.text);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Add tag"))
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                  icon: const Icon(Icons.add))
            ],
          ),
        ),
        divider()
      ],
    );
  }

  Widget bodyView() {
    return (uid != "")
        ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(getTag(uid).tag),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              dateView(_list[index]),
                              titleView(_list[index]),
                              remindAtView(_list[index]),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: Text(noTagSelected),
          );
  }

  Widget dateView(TagContent tagContent) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formatedDate(tagContent.createdTime)),
          Text(formatedTime(tagContent.createdTime))
        ],
      ),
    );
  }

  Widget titleView(TagContent tagContent) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16, bottom: 8),
        child:
            (tagContent.title != "") ? Text(tagContent.title) : Text("title"));
  }

  Widget remindAtView(TagContent tagContent) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16, bottom: 8),
        child: Text(
            "Set Alarm on ${formatedDate(tagContent.reminderTime)} ${formatedTime(tagContent.reminderTime)}"));
  }

  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 60));
    FlutterNativeSplash.remove();
  }

  String formatedDate(DateTime dateTime) {
    String res = dateFormat.format(dateTime);
    return res;
  }

  String formatedTime(DateTime dateTime) {
    String res = timeFormat.format(dateTime);
    return res;
  }
}
