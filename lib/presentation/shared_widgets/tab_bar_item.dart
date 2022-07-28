
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/functions/widget_functions.dart';
import '../board/task_cubit.dart';

class TabBarItem extends StatelessWidget {
  bool isSelected;
  String title;
    TabBarItem({
    Key? key, required this.title,required this.isSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: (){
        TaskCubit.get(context).changShowType(title);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color:isSelected? Colors.black:Colors.transparent,width: isSelected?1.w:0),)
        ),
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Center(
          child: Text(
            title,
            style: openSans(14.sp,isSelected? Colors.black:Colors.black54, FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
