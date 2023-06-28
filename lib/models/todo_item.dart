import 'dart:convert';

class TodoItem {
  TodoItem({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  factory TodoItem.fromJson(String source) =>
      TodoItem.fromMap(json.decode(source) as Map<String, dynamic>);

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  final String description;
  final int? id;
  final bool isDone;
  final String title;

  TodoItem copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  String toJson() => json.encode(toMap());
}
