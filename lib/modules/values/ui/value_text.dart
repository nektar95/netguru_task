import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ValueText extends StatelessWidget {
  const ValueText({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).shadowColor,
      child: AutoSizeText(
        text,
        minFontSize: 20,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Caveat',
            fontWeight: FontWeight.w700,
            color: Theme.of(context).accentColor,
            fontSize: 40),
      ),
    );
  }
}
