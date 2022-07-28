
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_app/utils/functions/widget_functions.dart';
import 'package:todo_app/utils/styles/style.dart';
import '../../data/constant.dart';


class DatePickerWidget extends StatefulWidget {
  final DateRangePickerController datePickerController=DateRangePickerController();

  final String title;

    DatePickerWidget({
    Key? key,
    required this.title,

  }) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.datePickerController.selectedDate=DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMaterialModalBottomSheet(
            context: context,
            builder: (
                BuildContext context,
                ) {
              return Material(
                color: Colors.black12,
                child: Container(
                  height: .42.sh,
                  padding:
                  EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SfDateRangePicker(
                        initialDisplayDate: DateTime.now(),
                         allowViewNavigation: true,
                        showNavigationArrow: true,
                        selectionMode:
                        DateRangePickerSelectionMode.single,
                        headerHeight: 40.h,
                        cancelText: "Cancel",
                        confirmText: "Done",
                        onSubmit: (time) {
                          setState(() {
                            widget.datePickerController.selectedDate = time as DateTime?;
                            // start = time as DateTime?;
                          });
                          Navigator.pop(context);
                        },
                        controller: widget.datePickerController,
                        showActionButtons: true,
                        headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          space(16.h, 0),
          Text(
            widget.title,
            style: openSans(14.sp, Colors.black, FontWeight.w600),
          ),
          space(8.w, 0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, ),
                  decoration: formDecoration,
                  height: 48.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        formatter.format(widget.datePickerController.selectedDate!).toString(),
                        style: openSans(
                            14.sp, Colors.black, FontWeight.w500),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
