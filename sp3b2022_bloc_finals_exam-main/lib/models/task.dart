import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  bool? isDone;
  bool? isCancelled;
  bool? isFavourite;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isDone,
    this.isCancelled,
    this.isFavourite,
  }) {
    isDone = isDone ?? false;
    isCancelled = isCancelled ?? false;
    isFavourite = isFavourite ?? false;
  }

  Task copyWith(
      {String? id,
      String? title,
      String? description,
      String? date,
      bool? isDone,
      bool? isCancelled,
      bool? isFavourite}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: title ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isCancelled: isCancelled ?? this.isCancelled,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        isCancelled,
        isDone,
        isFavourite,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isDone': isDone,
      'isCancelled': isCancelled,
      'isFavourite': isFavourite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      isDone: map['isDone'],
      isCancelled: map['isCancelled'],
      isFavourite: map['isFavourite'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
