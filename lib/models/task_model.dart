import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskModel {
  String? title;
  DateTime? deadline;
  String? startTime;
  String? endTime;
  String? remind;
  String? repeat;
  int? color;
  String? isCompleted;
  String? isFavourited;
  bool? isRemoved;
  TaskModel(
      {this.title,
      this.startTime,
      this.endTime,
      this.deadline,
      this.remind,
      this.repeat,
      this.color,
      this.isCompleted,
      this.isFavourited,
      this.isRemoved});
  TaskModel.fromMap(Map map) {
    title = map['title'];
    startTime = map['startTime'];
    endTime = map['endTime'];
    deadline = map['deadline'];
    remind = map['remind'];
    repeat = map['repeat'];
    color = map['color'];
    isCompleted = map['isCompleted'];
    isFavourited = map['isFavourited'];
    isRemoved = map['isRemoved'];
  }
  Map<String, dynamic> toMap() => {
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
        'deadline': deadline,
        'remind': remind,
        'repeat': repeat,
        'color': color,
        'isCompleted': isCompleted,
        'isFavourited': isFavourited,
        'isRemoved': isRemoved
      };
}
