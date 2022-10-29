import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:memo_me/data/data.dart';
import 'package:memo_me/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  List _list = listTagContent;
  String uid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
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

  void refreshBodyContent() {
    var listTemp =
        listTagContent.where((element) => element.uid == uid).toList();

    setState(() {
      _list = listTemp;
    });
  }

  void submitTag(String tag) {
    bool isDuplicate;

    String uid = randomNumber();

    for (var element in listTag) {
      if (element.uniqueId == randomNumber()) {
        isDuplicate = true;
        uid = randomNumber();
      }
    }

    listTag.add(Tag(id: 1, tag: tag, uniqueId: uid));
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
                _list = listTagContent;
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
            heroTag: addnote,
            child: const Icon(Icons.add, size: 38),
            onPressed: () {
              Navigator.of(context).pushNamed(addnote);
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
                uid = listTag[index].uniqueId;
                print(uid);
                refreshBodyContent();
                Navigator.of(context).pop();
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
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      dateView(),
                      titleView(),
                      contentView(),
                    ],
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text("Please select tag"),
          );
  }

  Widget dateView() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Date Month"), Text("xx.xx")],
      ),
    );
  }

  Widget titleView() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16, bottom: 8),
        child: (true) ? Text("title") : Text(""));
  }

  Widget contentView() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text("content"),
    );
  }

  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 60));
    FlutterNativeSplash.remove();
  }
}
