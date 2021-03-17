import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FailureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Lottie.asset('assets/lottie/error_dog.json', height: 200, width: 200),
    );
  }
}
