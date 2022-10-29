import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:memo_me/constant.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(addNoteTitle),
        leading: IconButton(
          onPressed: () => popPage(context), icon: const Icon(Icons.close)),
        actions: [
          ElevatedButton(
            onPressed: () => popPage(context), child: Container())
        ],
      ),
    );
  }
}