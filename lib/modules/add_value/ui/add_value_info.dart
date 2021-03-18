import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AddValueInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topMarginSize = screenHeight < 800 ? 170.0 : 250.0;
    final topPadding = screenHeight < 800 ? 2.0 : 32.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
      child: Center(
        child: Lottie.asset('assets/lottie/write.json',
            height: topMarginSize, width: topMarginSize),
      ),
    );
  }
}
