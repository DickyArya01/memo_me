import 'package:memo_me/constant.dart';

class Tag {
  int id;
  String tag;
  String uniqueId;

  Tag({required this.id, required this.tag, required this.uniqueId});
}

List<Tag> listTag = [
];

class TagContent {
  int id;
  String? title;
  String content;
  String uid;

  TagContent({required this.id, required this.content, required this.uid});
}

List<TagContent> listTagContent = [
];
