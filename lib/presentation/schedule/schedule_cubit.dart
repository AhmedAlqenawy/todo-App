 import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/constant.dart';
import 'package:todo_app/presentation/schedule/schedule_states.dart';
import '../../services/local_database.dart';

class SchedulCubit extends Cubit<ScheduleStates> {
  SchedulCubit() : super(InitScheduleTaskState());

  List? tasksByDate = [];
  int interval = 0;
  String date = formatter.format(DateTime.now()).toString();
  static SchedulCubit get(context) => BlocProvider.of(context);

  void changDate(String date) {
    this.date = date;
    emit(ChangDateState());
    getTasksByDateList();
  }

  void changInterval(int val) {
    interval += val;
    emit(ChangDateState());
  }

  void getTasksByDateList() {
    CacheService().getAllTasks().then((value) {
      tasksByDate = value;
      emit(GetTasksByDateFromDatabaseState());
      CacheService().getAllTasks().then((value) {
        tasksByDate = [];
        value.forEach((element) {

          if (DateTime.parse(element["date"]).isBefore(DateTime.parse(date)) ==
              true ||DateTime.parse(element["date"]).difference(DateTime.parse(date)).inDays==0) {
             if (element["repeat"] == "Daily") {
              tasksByDate!.add(element);
            } else if (element["repeat"] == "Weekly" &&
                DateFormat.E().format(DateTime.parse(element["date"])) ==
                    DateFormat.E().format(DateTime.parse(date))) {
              tasksByDate!.add(element);
            } else if (element["repeat"] == "Monthly"&&
                DateTime.parse(element["date"]).day ==DateTime.parse(date).day) {
              tasksByDate!.add(element);
            } else if (element["repeat"] == "Yearly" &&  DateTime.parse(element["date"]).day ==DateTime.parse(date).month &&DateTime.parse(element["date"]).day ==DateTime.parse(date).month)  {
              tasksByDate!.add(element);
            }
          }
        });
         emit(GetTasksByDateFromDatabaseState());
      });
    });
  }
}
