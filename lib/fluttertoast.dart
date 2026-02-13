import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message{

 static void show({
  String message = "Done!",
  ToastGravity = ToastGravity.BOTTOM,
  int timeInsecforweb = 1,
  Color backgroundColor = Colors.green,
  Color textColor = Colors.white,
  double fontSize =16,

 })

 {
  Fluttertoast.showToast(
    msg:  message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity,
    timeInSecForIosWeb: timeInsecforweb,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,

  );
 }
 
}