import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/board/task_cubit.dart';
import 'package:todo_app/utils/functions/random_color.dart';
import 'package:todo_app/utils/styles/colors.dart';

import '../../utils/functions/widget_functions.dart';

class BoardTaskItem extends StatelessWidget {
  var task;
  BoardTaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customCheckedBox(
                  getRandomColor()!, task['isCompleted'] == "true"),
              space(0, 8.w),
              Text(
                task["title"],
                style: openSans(16.sp, Colors.black, FontWeight.w500),
              ),
            ],
          ),

          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              size: 19.r,
              color: buttonColor,
            ),

            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
               // padding: EdgeInsets.symmetric(horizontal:0.w),
                child: SizedBox(width: 20.w, child: Center(child: Icon(Icons.delete_forever,))),
                onTap: () {
                  TaskCubit.get(context).deleteTask(task['id']);
                },
              ),
              PopupMenuItem(
                child: SizedBox(
                  width: 20.w,
                  child: Icon(task["isFav"] == "true"
                      ? Icons.favorite
                      : Icons.favorite_border,
                   color: Colors.red,
                  ),
                ),
                onTap: () {
                  TaskCubit.get(context).updateTask(task['id'],
                      task['isFav'] == "false" ? "true" : "false", "isFav");
                },
              ),
              PopupMenuItem(
                child: SizedBox(
                  width: 20.w,
                  child: Icon(Icons.done_outlined),
                ),
                onTap: () {
                  TaskCubit.get(context).updateTask(
                      task['id'],
                      task['isCompleted'] == "false" ? "true" : "false",
                      "isCompleted");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
