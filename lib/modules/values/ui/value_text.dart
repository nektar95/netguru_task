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
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            child: child,
            position: Tween<Offset>(
                    begin: const Offset(1.2, -2.4), end: const Offset(0.0, 0.0))
                .animate(animation),
          );
        },
        child: AutoSizeText(
          text,
          key: ValueKey<String>(text),
          minFontSize: 20,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Caveat',
              fontWeight: FontWeight.w700,
              color: Theme.of(context).accentColor,
              fontSize: 40),
        ),
      ),
    );
  }
}
