import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:memo_me/constant.dart';
import 'package:memo_me/data/data.dart';
import 'package:memo_me/database/memo_database.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController contentTextController = TextEditingController();

  late DateTime remindTime;

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
                  submitTagContent(args, remindTime);
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
        Row(
          children: [
            GestureDetector(
                child: Container(
                    color: Colors.blue, child: Text("Select Date and Time")),
                onTap: () async {
                  final date = await pickDateTime();
                  if (date == null) return;
                  setState(() {
                    remindTime = date;
                  });
                }),
          ],
        )
      ]),
    );
  }

  Future submitTagContent(Tag args, DateTime dateTime) async {
    await MemoDatabase.instance.insertTagContent(TagContent(
        title: "",
        content: "",
        createdTime: DateTime.now(),
        reminderTime: dateTime,
        uid: args.uid));
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000));

  Future<TimeOfDay?> pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    setState(() {
      remindTime = dateTime;
    });
  }
}
