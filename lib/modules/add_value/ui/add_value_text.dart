import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:netguru_task/l10n/l10n.dart';

class AddValueText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AutoSizeText(AppLocalizations.of(context).addNewValueInfo,
          minFontSize: 14,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).accentColor,
              fontSize: 18)),
    );
  }
}
