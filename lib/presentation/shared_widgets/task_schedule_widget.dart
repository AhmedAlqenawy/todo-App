import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/functions/random_color.dart';
import '../../utils/functions/widget_functions.dart';

class TaskScheduleWideget extends StatelessWidget {
  String time,task;
  bool isCompleted;
  TaskScheduleWideget({
    Key? key,required this.isCompleted,required this.task,required this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 75.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: getRandomColor()!,
          borderRadius: BorderRadius.circular(16.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time,textScaleFactor: 1,
                style: openSans(16.h, Colors.white, FontWeight.w600),),
              Text(task,textScaleFactor: 1,
                style: openSans(16.h, Colors.white, FontWeight.w600),),
            ],
          ),
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white)
              //color: Colors.white,
            ),
            child: Center(
              child: isCompleted?Icon(Icons.done,color: Colors.white,size: 13.r,):space(0,0),
            ),
          )
        ],
      ),
    );
  }
}
