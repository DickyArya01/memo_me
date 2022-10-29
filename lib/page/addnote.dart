import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:memo_me/constant.dart';
import 'package:memo_me/data/data.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController contentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Tag;
    return Scaffold(
      appBar: AppBar(
        title: Text(addNoteTitle),
        leading: IconButton(
            onPressed: () => popPage(context), icon: const Icon(Icons.close)),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () {
                  listTagContent.add(TagContent(
                      id: 1,
                      title: titleTextController.text,
                      content: contentTextController.text,
                      uid: args.uniqueId));
                  popPage(context);
                },
                child: Container(
                  child: Text("Save"),
                )),
          )
        ],
      ),
      body: ListView(children: [
        TextField(
          controller: titleTextController,
        ),
        TextField(
          controller: contentTextController,
        ),
      ]),
    );
  }
}
