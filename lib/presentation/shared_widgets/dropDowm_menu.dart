import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/functions/widget_functions.dart';

class DropdownWidget extends StatefulWidget {
  String? dropdownValue, hint;
  var dropdownItems;

  DropdownWidget({
    Key? key,
    required this.dropdownItems,
    required this.dropdownValue,
    required this.hint,
  }) : super(key: key);
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 24.w),
      //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE6E6E6)),
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xffF8F8F6)),
      width: 327.w,
      height: 48.h,
      child: Center(
        child: DropdownButton(
          value: widget.dropdownValue,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 20.r,
          ),
          hint: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.hint.toString(),
                style: openSans(14.sp, Colors.black, FontWeight.w400),
              ),
            ],
          ),
          underline: space(0, 0),
          iconSize: 0,
          dropdownColor: Colors.white,
          selectedItemBuilder: (BuildContext context) {
            return widget.dropdownItems.map<Widget>((String item) {
              return SizedBox(
                width: 270.w,
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item,
                      style: openSans(14.sp, Colors.black, FontWeight.normal),
                    ),
                  ],
                ),
              );
            }).toList();
          },
          items: widget.dropdownItems
              .map<DropdownMenuItem<String>>((String items) {
            return DropdownMenuItem(
              value: items,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: items == widget.dropdownValue
                      ? const Color(0xffF8F8F6)
                      : Colors.white,
                ),
                width: 270.w,
                child: Text(
                  items,
                  style: openSans(14.sp, Colors.black, FontWeight.normal),
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              widget.dropdownValue = newValue.toString();
            });
          },
        ),
      ),
    );
  }
}
