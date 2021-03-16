import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netguru_task/app/app.dart';

void setup() {
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    runApp(const App());
  });
}
