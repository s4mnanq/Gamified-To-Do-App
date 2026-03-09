import 'dart:convert';

class TaskModel {
  final String? title;
  final String? description;
  final String? due;
  final String? type;
  final String? xp;
  final String? priority;

  TaskModel({
    this.title,
    this.description,
    this.due,
    this.xp,
    this.type,
    this.priority,
  });

  TaskModel copyWith({
    String? title,
    String? description,
    String? due,
    String? xp,
    String? type,
    String? priority,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      due: due ?? this.due,
      xp: xp ?? this.xp,
      type: type ?? this.type,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'due': due,
      'xp': xp,
      'type': type,
      'priority': priority,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      due: map['due'] != null ? map['due'] as String : null,
      xp: map['xp'] != null ? map['xp'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      priority: map['priority'] != null ? map['priority'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(title: $title, description: $description, due: $due, xp: $xp ,type: $type, priority: $priority)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.due == due &&
        other.xp == xp &&
        other.type == type &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        due.hashCode ^
        xp.hashCode ^
        type.hashCode ^
        priority.hashCode;
  }
}
