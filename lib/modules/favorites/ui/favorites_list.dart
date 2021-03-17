import 'package:flutter/material.dart';
import 'package:netguru_task/modules/favorites/ui/favorites_list_item.dart';
import 'package:netguru_task/modules/values/models/value.dart';

import 'favorites_list_empty.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({Key key, this.values}) : super(key: key);

  final List<Value> values;

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    return widget.values.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.values.length,
            itemBuilder: (context, index) {
              return FavoritesListItem(
                value: widget.values[index],
              );
            })
        : FavoritesListEmpty();
  }
}
