import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/modules/favorites/bloc/bloc.dart';
import 'package:netguru_task/modules/favorites/ui/favorites_list.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    BlocProvider.of<FavoritesBloc>(context).add(GetFavoritesValuesData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is FavoritesLoadedState) {
          return FavoritesList(
            values: state.values,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
