import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/functions/widget_functions.dart';
import 'package:todo_app/utils/styles/colors.dart';

class MainButton extends StatelessWidget {
  String title;

  Function onTap;
  MainButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50.h,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: Text(
            title,
            style: openSans(14.sp, Colors.white, FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
