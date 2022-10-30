import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:memo_me/constant.dart';
import 'package:memo_me/data/data.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController contentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Tag;
    return Scaffold(
      appBar: AppBar(
        title: Text(edit),
        leading: IconButton(
            onPressed: () => popPage(context), icon: const Icon(Icons.close)),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () {
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