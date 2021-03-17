import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netguru_task/l10n/l10n.dart';

class FavoritesListEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/empty.json', height: 200, width: 200),
          AutoSizeText(AppLocalizations.of(context).emptyFavoriteList,
              minFontSize: 14,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).accentColor,
                  fontSize: 20))
        ],
      ),
    );
  }
}
