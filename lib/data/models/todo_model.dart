// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodoModel {
  final String userId;
  final String id;
  final String title;
  final String description;
  final String isCompleted;
  TodoModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  TodoModel copyWith({
    String? userId,
    String? id,
    String? title,
    String? description,
    String? isCompleted,
  }) {
    return TodoModel(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      userId: map['userId'] as String,
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodoModel(userId: $userId, id: $id, title: $title, description: $description, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      isCompleted.hashCode;
  }
}
