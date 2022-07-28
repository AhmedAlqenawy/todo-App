import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/presentation/shared_widgets/toast_massage.dart';
import 'package:todo_app/utils/styles/colors.dart';
import '../../data/constant.dart';
import '../../utils/functions/navigation.dart';
import '../../utils/functions/widget_functions.dart';
import '../../utils/styles/style.dart';
import '../board/board_screen.dart';
import '../board/task_cubit.dart';
import '../shared_widgets/DatePicker.dart';
import '../shared_widgets/dropDowm_menu.dart';
import '../shared_widgets/main_button.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateRangePickerController deadlineController = DateRangePickerController();

  DropdownWidget reminderTime = DropdownWidget(
    hint: "select remind du time",
    dropdownItems:
        List.generate(4, (index) => "${(index + 1) * 5} minutes early"),
    dropdownValue: null,
  );
  DropdownWidget repeatTime = DropdownWidget(
    hint: "select Repeat time",
    dropdownItems: const ["Daily", "Weekly", "Monthly", "Yearly"],
    dropdownValue: null,
  );

  Color screenPickerColor=Colors.lightGreen;
  DatePickerWidget dateWidget = DatePickerWidget(
    title: 'Date',
  );

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  FocusNode titleNode = FocusNode();
  TextEditingController titleController=TextEditingController();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20.r,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Add Task",
          style: openSans(22.sp, Colors.black, FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          space(24.h, 0),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: openSans(14.sp, Colors.black, FontWeight.w600),
                    ),
                    space(8.w, 0),
                    TextField(
                      cursorColor: const Color(0xff999999),
                      maxLines: 1,
                      focusNode: titleNode,
                      controller: titleController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              color: Color(0xffE8F9F8),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: mainColor, width: 1.h),
                          ),
                          hintText: "Task Title",
                          hintStyle:
                              openSans(14.sp, Colors.black26, FontWeight.w500),
                          contentPadding: EdgeInsets.only(
                              top: 11.h, left: 16.w, right: 16.w),
                          fillColor: mainColor,
                          filled: true,
                          alignLabelWithHint: true),
                    ),
                    dateWidget,
                    space(24.h, 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start time",
                              style: openSans(
                                  14.sp, Colors.black, FontWeight.w600),
                            ),
                            space(8.w, 0),
                            GestureDetector(
                              onTap: () async {
                                startTime = await showTimePicker(
                                  context: context,
                                  initialTime: startTime?? const TimeOfDay(hour: 0, minute: 0),
                                );
                                setState(() {});
                              },
                              child: Container(
                                decoration: formDecoration,
                                width: 120.w,
                                height: 48.h,
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(startTime != null
                                        ? "${startTime!.hour} : ${startTime!.minute}"
                                        : "Start time"),
                                    Icon(
                                      Icons.access_time,
                                      size: 20.r, color: buttonColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "End time",
                              style: openSans(
                                  14.sp, Colors.black, FontWeight.w600),
                            ),
                            space(8.w, 0),
                            GestureDetector(
                              onTap: () async {
                                endTime = await showTimePicker(
                                  context: context,
                                  initialTime: const TimeOfDay(hour: 0, minute: 0),
                                );
                                setState((){});
                              },
                              child: Container(
                                decoration: formDecoration,
                                width: 120.w,
                                height: 48.h,
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(endTime != null
                                        ? "${endTime!.hour} : ${endTime!.minute}"
                                        : "End time"),
                                    Icon(
                                      Icons.access_time,color: buttonColor,
                                      size: 20.r,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    space(24.h, 0),
                    Text(
                      "Remind",
                      textScaleFactor: 1,
                      style: openSans(14.sp, Colors.black, FontWeight.w600),
                    ),
                    space(8.w, 0),
                    reminderTime,
                    space(24.h, 0),
                    Text(
                      "Repeat",
                      textScaleFactor: 1,
                      style: openSans(14.sp, Colors.black, FontWeight.w600),
                    ),
                    space(8.w, 0),
                    repeatTime,
                    space(8.w, 0),
                    /*ColorIndicator(
                      color: screenPickerColor,
                      height: 40,
                      width: 40,
                      borderRadius: 3,
                      onSelect: () async {
                        final Color _colorBeforeDialog = screenPickerColor;
                        if (!(await colorPickerDialog())) {
                          setState(() {
                            screenPickerColor = _colorBeforeDialog;
                          });
                        }
                      },

                      *//*
                      onColorChanged: (Color color) =>
                          setState(() => screenPickerColor = color),

                      heading: Text(
                        'Select color',
                        style: TextStyle(color: screenPickerColor),*//*

                      ),*/

                  ],
                ),
              ),
            ),
          ),
          MainButton(
              title: "Create Task",
              onTap: () async{
                String msg="";
                if(titleController.text=="") {
                  msg="Please enter title";
                }else if(dateWidget.datePickerController.selectedDate==null){
                  msg="Please select date";
                }else if(startTime==null){
                  msg="Please start Time";
                }else if(endTime==null){
                  msg="Please end Time";
                }else if(repeatTime.dropdownValue == null){
                  msg="Please repeat Time";
                }
                else if(reminderTime.dropdownValue == null){
                  msg="Please reminder Time";
                }
                if(msg=="") {
                  TaskCubit().insertTask(TaskModel(

                  title: titleController.text,
                  date: formatter.format(dateWidget.datePickerController.selectedDate!).toString(),
                  startTime:startTime!.hour >=12? "${startTime!.hour-12} : ${startTime!.minute} PM":"${startTime!.hour} : ${startTime!.minute} AM",
                  endTime: endTime!.hour >=12? "${endTime!.hour-12} : ${endTime!.minute} PM":"${endTime!.hour} : ${endTime!.minute} AM",
                  remind: reminderTime.dropdownValue,
                  repeat: repeatTime.dropdownValue,
                  isFav: "false",
                  isCompleted: "false",

                ),startTime!);
                  msg="Added";
                  showToast(msg: msg, state: ToastStates.SUCCESS);
                  navigateTo(context, const BoardView());
                }
                else{
                  showToast(msg: msg, state: ToastStates.ERROR);
                }


              }),
          space(40.h, 0)
        ],
      ),
    );
  }
  /*Future<bool> colorPickerDialog() async {
      return ColorPicker(
      color: screenPickerColor,
      onColorChanged: (Color color) =>
          setState(() => screenPickerColor = color),

      borderRadius: 3,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      spacing: 3,
      runSpacing: 3,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),


    ).showPickerDialog(
      context,
      constraints:
      const BoxConstraints(minHeight: 475, minWidth: 480, maxWidth: 480),
    );
  }*/

}
