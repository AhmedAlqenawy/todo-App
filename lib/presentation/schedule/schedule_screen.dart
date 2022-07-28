import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/schedule/schedule_cubit.dart';
import 'package:todo_app/presentation/schedule/schedule_states.dart';
import 'package:todo_app/presentation/shared_widgets/task_schedule_widget.dart';

import '../../data/constant.dart';
import '../../utils/functions/widget_functions.dart';
import '../../utils/styles/colors.dart';
import 'package:intl/intl.dart';


class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({Key? key}) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20.r,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Schedule",
          style: openSans(22.sp, Colors.black, FontWeight.bold),
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) => SchedulCubit()..getTasksByDateList(),
        child: BlocConsumer<SchedulCubit, ScheduleStates>(
            listener: (context, state) {},
            builder: (context, state) {
              SchedulCubit cubit = SchedulCubit.get(context);
              return Column(
                children: [
                  SizedBox(
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween  ,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.changInterval(-1  );
                          },
                          child: SizedBox(
                            width: 33.w,height: 100.h,
                            child: Icon(Icons.arrow_back_ios_new,color: buttonColor,size: 20.r,),
                          ),
                        ),

                        for (int i = 0; i < 7; i++)
                          GestureDetector(
                            onTap: () {
                              cubit.changDate(formatter
                                  .format(DateTime.now()
                                  .add(Duration(days: i+cubit.interval*7)))
                                  .toString());
                            },
                            child: DaysWidget(
                                dateTime: DateTime.now().add(Duration(days: i+cubit.interval*7)),
                                isSelected: cubit.date ==
                                    formatter
                                        .format(DateTime.now()
                                        .add(Duration(days: i+cubit.interval*7)))
                                        .toString()),
                          ),
                        GestureDetector(
                          onTap: () {
                            cubit.changInterval(1);

                          },
                          child: SizedBox(
                            width: 33.w,height: 100.h,
                            child: Center(child: Icon(Icons.arrow_forward_ios,color: buttonColor,size: 20.r,)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  line(2.h, double.maxFinite, Colors.black12),
                  space(16.h, 0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.EEEE()
                              .format(DateTime.parse(cubit.date)),
                          textScaleFactor: 1,
                          style: openSans(
                              18.h, Colors.black, FontWeight.w700),
                        ),
                        Text(
                          cubit.date,
                          textScaleFactor: 1,
                          style: openSans(
                              14.h, Colors.black, FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  space(16.h, 0),
                  BlocConsumer<SchedulCubit, ScheduleStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var tasks=cubit.tasksByDate;
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < tasks!.length; i++)
                                TaskScheduleWideget(
                                  time:  tasks[i]['startTime'],
                                  task: tasks[i]['title'],
                                  isCompleted:tasks[i]['isCompleted']=="true"? true:false,
                                ),
                              space(16.h, 0),
                            ],
                          ),
                        );
                      }),

                ],
              );
            }),
      ),
    );
  }
}

class DaysWidget extends StatelessWidget {
  final DateTime dateTime;
  bool isSelected;
  DaysWidget({Key? key, required this.dateTime, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w),
      child: Container(
        width: 38.w,
        height: 85.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: isSelected ? buttonColor : Colors.transparent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.MMM().format(dateTime),
              textScaleFactor: 1,
              style: openSans(15.h, isSelected ? Colors.white : Colors.black,
                  FontWeight.w500),
            ),
            space(5.h, 0),
            Text(
              DateFormat.E().format(dateTime),
              textScaleFactor: 1,
              style: openSans(15.h, isSelected ? Colors.white : Colors.black,
                  FontWeight.w500),
            ),
            space(5.h, 0),
            Text(
              dateTime.day.toString(),
              textScaleFactor: 1,
              style: openSans(15.h, isSelected ? Colors.white : Colors.black,
                  FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
