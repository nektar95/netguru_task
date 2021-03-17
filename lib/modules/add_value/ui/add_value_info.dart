import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AddValueInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/lottie/write.json', height: 200, width: 200),
    );
  }
}
