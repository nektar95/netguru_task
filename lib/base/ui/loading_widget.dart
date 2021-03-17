import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          if (Platform.isAndroid) {
            return const CircularProgressIndicator();
          } else if (Platform.isIOS) {
            return Theme(
                data: ThemeData(
                    cupertinoOverrideTheme:
                        const CupertinoThemeData(brightness: Brightness.dark)),
                child: const CupertinoActivityIndicator(
                  radius: 25,
                ));
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
