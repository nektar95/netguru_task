import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/modules/add_value/bloc/add_value_bloc.dart';
import 'package:netguru_task/modules/favorites/bloc/bloc.dart';
import 'package:netguru_task/modules/home/bloc/bloc.dart';
import 'package:netguru_task/modules/values/repository/values_repository.dart';
import 'package:provider/provider.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final firebaseCrashlytics =
        Provider.of<FirebaseCrashlytics>(context, listen: false);

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            valuesRepository: RepositoryProvider.of<ValuesRepository>(context),
            firebaseCrashlytics: firebaseCrashlytics,
          ),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(
            valuesRepository: RepositoryProvider.of<ValuesRepository>(context),
            firebaseCrashlytics: firebaseCrashlytics,
          ),
        ),
        BlocProvider<AddValueBloc>(
          create: (context) => AddValueBloc(
            valuesRepository: RepositoryProvider.of<ValuesRepository>(context),
            firebaseCrashlytics: firebaseCrashlytics,
          ),
        ),
      ],
      child: child,
    );
  }
}
