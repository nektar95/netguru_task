import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:netguru_task/di/storage_providers.dart';
import 'package:provider/provider.dart';

class ServiceProviders extends StatelessWidget {
  const ServiceProviders({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StorageProviders(
      child: MultiProvider(
        providers: [
          Provider<FirebaseCrashlytics>(
            create: (_) => FirebaseCrashlytics.instance,
          ),
        ],
        child: child,
      ),
    );
  }
}
