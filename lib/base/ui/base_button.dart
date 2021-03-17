import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton(this.text, {Key key, this.onPressed, this.width})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: FlatButton(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).primaryColor,
        disabledColor: Theme.of(context).primaryColorLight,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
