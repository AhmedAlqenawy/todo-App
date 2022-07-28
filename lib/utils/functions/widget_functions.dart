import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

space(double h, double w) {
  return SizedBox(
    height: h,
    width: w,
  );
}

line(double h, double w, Color color) {
  return Container(
    height: h,
    width: w,
    color: color,
  );
}

customCheckedBox(  Color color,bool checked) {
  return Container(
    width: 20.w,
    height: 20.h,
    decoration: BoxDecoration(
      color: checked?color:Colors.transparent,
       border: Border.all(color: color,width:checked?0 :2.w),
      borderRadius: BorderRadius.circular(6.r)
    ),
    child: Center(
        child:checked==true?Icon(Icons.done,size: 16.w,color: Colors.white,):space(0,0),
    ),
  );
}

TextStyle openSans(double fontSize, Color color, FontWeight fontWeight,
    {bool underline = false,
    bool overLine = false,
    Color decorationColor = Colors.black}) {
  return GoogleFonts.openSans(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    decoration: underline != false
        ? TextDecoration.underline
        : overLine != false
            ? TextDecoration.lineThrough
            : TextDecoration.none,
    decorationColor: decorationColor,
  );
}
