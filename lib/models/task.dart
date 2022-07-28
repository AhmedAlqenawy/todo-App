import 'dart:convert';

TaskModel TaskModelFromJson(String str) =>
    TaskModel.fromJson(json.decode(str));
class TaskModel {
  int? id;
  String? title;
  String? startTime;
  String? endTime;
  String? date;
  String? remind;
  String? repeat;
  String? isFav;
  String? isCompleted;


  TaskModel({
    this.id,
    this.title,
    this.startTime,
    this.date,
    this.endTime,
    this.remind,
    this.repeat,
    this.isCompleted,
    this.isFav
  });
  factory TaskModel.fromJson(Map<dynamic, dynamic> json) => TaskModel(
    title: json["title"],
    id: json["id"],
    startTime: json["startTime"],
    date: json["date"],
    endTime: json["endTime"],
    remind: json["remind"],
    repeat: json["repeat"],
    isCompleted: json["isCompleted"],
    isFav: json["isFav"],

  );
}
