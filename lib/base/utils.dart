import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, BuildContext context) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Theme.of(context).accentColor,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Theme.of(context).backgroundColor,
  );
}
