
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String msg,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: _chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

Color _chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.WARNING:
      return Colors.yellow;
    case ToastStates.ERROR:
      return Colors.red;
  }
}

enum ToastStates { SUCCESS, ERROR, WARNING }