import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/base/ui/failure_widget.dart';
import 'package:netguru_task/base/ui/loading_widget.dart';
import 'package:netguru_task/base/utils.dart';
import 'package:netguru_task/l10n/l10n.dart';
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
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesErrorState) {
          var message = AppLocalizations.of(context).unknownException;

          switch (state.errorCode) {
            case ErrorCode.unexpected:
              message = AppLocalizations.of(context).unknownException;
              break;
            case ErrorCode.storageError:
              message = AppLocalizations.of(context).storageException;
              break;
          }

          setState(() {
            showToast(message, context);
          });
        }
      },
      builder: (context, state) {
        if (state is FavoritesErrorState) {
          return FailureWidget();
        } else if (state is FavoritesLoadedState) {
          return FavoritesList(
            values: state.values,
          );
        }
        return LoadingWidget();
      },
    );
  }
}
