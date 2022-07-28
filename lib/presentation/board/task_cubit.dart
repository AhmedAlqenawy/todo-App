import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/constant.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/presentation/board/task_states.dart';
import 'package:todo_app/utils/shared/CacheHelper.dart';

import '../../services/alarm.dart';
import '../../services/local_database.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(InitTaskState());

  List? taskList = [];
  List? tasksByDate = [];
  String showType = "All";
  String date=formatter.format(DateTime.now()).toString();
  static TaskCubit get(context) => BlocProvider.of(context);

  void changShowType(String type) {
    showType = type;
    emit(ChangTabBarState());
    type == "All"
        ? getTasks()
        : type == "Completed"
            ? getCompletedTask()
            : type == "Uncompleted"
                ? getUnCompletedTask()
                : getFavoriteTask();
  }

  void changDate(String date) {
    this.date = date;
    emit(ChangDateState());

  }

  insertTask(TaskModel taskModel,TimeOfDay timeOfDay) async {
    CacheService().addTask(taskModel).then((value) {
      emit(InsertTasksIntoDatabaseState());
      getTasks();
      TaskNotification().ScheduledTaskNotification(
        taskModel.title,taskModel.date,CacheHelper.getData(key: "id")==null?CacheHelper.getData(key: "id"):CacheHelper.getData(key: "id")-1,taskModel.repeat,timeOfDay,taskModel.remind!
      );
    });
  }

  void getTasks() {
    CacheService().getAllTasks().then((value) {
      taskList = value;
      emit(GetTasksFromDatabaseState());
    });
  }

  void getTasksByDateList() {
    CacheService().getAllTasks().then((value) {
      tasksByDate = value;
      emit(GetTasksByDateFromDatabaseState());
      CacheService().getSpecificTasks("date", date).then((value) {
        taskList = value;
        emit(GetUncompletedTaskListState());
      });
    });
  }

  getFavoriteTask() {
    CacheService().getSpecificTasks("isFav", "true").then((value) {
      taskList = value;
      emit(GetFavoriteTaskListState());
    });
  }

  getCompletedTask() {
    CacheService().getSpecificTasks("isCompleted", "true").then((value) {
       taskList = value;
      emit(GetCompletedTaskListState());
    });
  }

  getUnCompletedTask() {
    CacheService().getSpecificTasks("isCompleted", "false").then((value) {
      taskList = value;
      emit(GetUncompletedTaskListState());
    });
  }

  deleteTask(int id){
    CacheService().deleteTask(id: id).then((value) {
      emit(DeleteTaskListState());
      TaskNotification().cancelNotificationWithId(id);
      showType = "All";

      getTasks();
    });
  }

  updateTask(int id,String value,String attribute){
    CacheService().updateTask(id: id,value: value,attribute: attribute).then((value) {
      emit(UpdateTaskListState() );
      showType = "All";
      getTasks();
    });
  }

}
