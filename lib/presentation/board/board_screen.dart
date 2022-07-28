import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/board/task_cubit.dart';
import 'package:todo_app/presentation/board/task_states.dart';
import 'package:todo_app/presentation/schedule/schedule_screen.dart';
import 'package:todo_app/presentation/shared_widgets/board_task_item.dart';
import 'package:todo_app/utils/styles/colors.dart';
import '../../utils/functions/navigation.dart';
import '../../utils/functions/widget_functions.dart';
import '../add_task/add_task_screen.dart';
import '../shared_widgets/main_button.dart';
import '../shared_widgets/tab_bar_item.dart';

class BoardView extends StatelessWidget {
  const BoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TaskCubit()..getTasks(),
      child: BlocConsumer<TaskCubit, TaskStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          TaskCubit cubit = TaskCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Board",
                    style: openSans(22.sp, Colors.black, FontWeight.w600),
                  ),
                  Row(
                    children: [

                      GestureDetector(
                        child: Icon(Icons.calendar_month_sharp,
                            color: buttonColor),
                        onTap: () {
                          navigateTo(context, ScheduleScreen());
                        },
                      ),
                      /*space(0, 8.w),
                      Icon(Icons.menu, color: Colors.black),*/
                    ],
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                space(16.h, 0),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 40.h,
                      ),
                      child: line(2.h, double.maxFinite, Colors.black12),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TabBarItem(
                            isSelected: cubit.showType == "All",
                            title: "All",
                          ),
                          TabBarItem(
                            isSelected: cubit.showType == "Completed",
                            title: "Completed",
                          ),
                          TabBarItem(
                            isSelected: cubit.showType == "Uncompleted",
                            title: "Uncompleted",
                          ),
                          TabBarItem(
                            isSelected: cubit.showType == "Favorite",
                            title: "Favorite",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                BlocConsumer<TaskCubit, TaskStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var tasks = cubit.taskList;
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //const Image(image: AssetImage("assets/img/no_data.webp")),
                                    tasks == null
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: .3.sh),
                                            child: CircularProgressIndicator(
                                              color: buttonColor,
                                            ))
                                        : tasks.isEmpty
                                            ? const Image(
                                                image: AssetImage(
                                                    "assets/img/no_data.webp"))
                                            : ListView.builder(
                                                itemCount: tasks.length,
                                                shrinkWrap: true,
                                                primary: false,
                                                padding: EdgeInsets.zero,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        index) {
                                                  return Column(
                                                    children: [
                                                      BoardTaskItem(
                                                        task: tasks[index],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                MainButton(
                    title: "Add a Task",
                    onTap: () {
                      navigateTo(context, AddTaskScreen());
                    }),
                space(40.h, 0)
              ],
            ),
          );
        },
      ),
    );
  }
}
