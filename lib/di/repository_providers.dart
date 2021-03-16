import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/modules/values/repository/values_repository.dart';
import 'package:netguru_task/modules/values/storage/values_storage.dart';
import 'package:provider/provider.dart';

class RepositoryProviders extends StatelessWidget {
  const RepositoryProviders({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final firebaseCrashlytics =
        Provider.of<FirebaseCrashlytics>(context, listen: false);
    final valuesStorage = Provider.of<ValuesStorage>(context, listen: false);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => ValuesRepository(
            firebaseCrashlytics: firebaseCrashlytics,
            valuesStorage: valuesStorage,
          ),
        ),
      ],
      child: child,
    );
  }
}
