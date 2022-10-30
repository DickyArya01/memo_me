import 'package:memo_me/constant.dart';
import 'package:memo_me/database/memo_database.dart';

class TagFields {
  static final List<String> values = [id, tag, uid];

  static const String id = '_id';
  static const String tag = 'tag';
  static const String uid = 'uid';
}

class Tag {
  final int? id;
  final String tag;
  final String uid;

  Tag({this.id, required this.tag, required this.uid});

  Tag copy({
    int? id,
    String? tag,
    String? uid,
  }) =>
      Tag(id: id ?? this.id, tag: tag ?? this.tag, uid: uid ?? this.uid);

  static Tag fromJson(Map<String, Object?> json) => Tag(
      id: json[TagFields.id] as int?,
      tag: json[TagFields.tag] as String,
      uid: json[TagFields.uid] as String);

  Map<String, Object?> toJson() => {
        TagFields.id: id,
        TagFields.tag: tag,
        TagFields.uid: uid,
      };
}

List<Tag> listTag = [];

class TagContentFields {
  static final List<String> values = [
    id,
    title,
    content,
    createdTime,
    reminderTime,
    uid
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String content = 'content';
  static const String createdTime = 'createdTime';
  static const String reminderTime = 'reminderTime';
  static const String uid = 'uid';
}

class TagContent {
  final int? id;
  final String title;
  final String content;
  final DateTime createdTime;
  final DateTime reminderTime;
  final String uid;

  TagContent({
    this.id,
    required this.title,
    required this.content,
    required this.createdTime,
    required this.reminderTime,
    required this.uid,
  });

  TagContent copy({
    int? id,
    String? title,
    String? content,
    DateTime? createdTime,
    DateTime? reminderTime,
    String? uid,
  }) =>
      TagContent(
          id: id ?? this.id,
          title: title ?? this.title,
          content: content ?? this.content,
          createdTime: createdTime ?? this.createdTime,
          reminderTime: reminderTime ?? this.reminderTime,
          uid: uid ?? this.uid);

  static TagContent fromJson(Map<String, Object?> json) => TagContent(
      id: json[TagContentFields.id] as int?,
      title: json[TagContentFields.title] as String,
      content: json[TagContentFields.content] as String,
      createdTime: DateTime.parse(json[TagContentFields.createdTime] as String),
      reminderTime:
          DateTime.parse(json[TagContentFields.reminderTime] as String),
      uid: json[TagContentFields.uid] as String);

  Map<String, Object?> toJson() => {
        TagContentFields.id: id,
        TagContentFields.title: title,
        TagContentFields.content: content,
        TagContentFields.createdTime: createdTime.toIso8601String(),
        TagContentFields.reminderTime: reminderTime.toIso8601String(),
        TagContentFields.uid: uid,
      };
}

List<TagContent> listTagContent = [];
