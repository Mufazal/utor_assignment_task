import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:utor_assignment/constants/pallete_constants.dart';

Future showFlushBar(BuildContext context, String message) {
  return Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColor.kBarItemColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
