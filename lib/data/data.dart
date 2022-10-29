import 'package:memo_me/constant.dart';

class Tag {
  int id;
  String tag;
  String uniqueId;

  Tag({required this.id, required this.tag, required this.uniqueId});
}

List<Tag> listTag = [
  Tag(id: 1, tag: "Daily Chores 1", uniqueId: "111"),
  Tag(id: 2, tag: "Daily Chores 2", uniqueId: "222")
];

class TagContent {
  int id;
  String? title;
  String content;
  String uid;

  TagContent({required this.id, required this.content, required this.uid});
}

List<TagContent> listTagContent = [
  TagContent(id: 1, content: "anjay", uid: "111"),
  TagContent(id: 1, content: "anjay", uid: "111"),
  TagContent(id: 2, content: "cok", uid: "222"),
  TagContent(id: 1, content: "anjay", uid: "111"),
];
