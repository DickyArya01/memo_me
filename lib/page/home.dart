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
            addTag(),
            listTag(),
          ],
        ),
      ),
    );
  }

  Widget listTag() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8, bottom: 8),
            padding: const EdgeInsets.only(left: 16),
            height: 48,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.bookmark),
                ),
                Text(list[index].tag)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget addTag() {
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
                                      submitTag(value, "1");
                                    },
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        submitTag(_controller.text, "1");
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

  void submitTag(String tag, String uniqueId) {
    Tag newTag = Tag(id: 1, tag: tag, uniqueId: uniqueId);
    list.add(newTag);
  }

  Widget bodyView() {
    return Container();
  }

  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 60));
    FlutterNativeSplash.remove();
  }
}
