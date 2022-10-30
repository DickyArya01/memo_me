import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:memo_me/constant.dart';
import 'package:memo_me/data/data.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TagContent;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                navigateToPageWithTagContent(context, editnote, args);
              },
              icon: Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete))
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: Text("Date time"),
          ),
          Container(
            child: Text("title"),
          ),
          Container(
            child: Text("content"),
          )
        ],
      ),
    );
  }
}
