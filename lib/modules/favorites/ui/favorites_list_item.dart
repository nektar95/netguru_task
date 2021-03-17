import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:netguru_task/modules/values/models/value.dart';

class FavoritesListItem extends StatelessWidget {
  const FavoritesListItem({Key key, this.value}) : super(key: key);

  final Value value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border.all(
            color: Theme.of(context).accentColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: AutoSizeText(value.text,
                  minFontSize: 14,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'Caveat',
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).accentColor,
                      fontSize: 26)),
            ),
          ],
        ),
      ),
    );
  }
}
