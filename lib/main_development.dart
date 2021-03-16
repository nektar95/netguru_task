import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:netguru_task/app/app_bloc_observer.dart';
import 'package:netguru_task/app/app_setup.dart';
import 'package:netguru_task/utility/flavors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  setAppFlavor(Flavor.dev);
  await Firebase.initializeApp();

  FlutterError.onError = (details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await runZonedGuarded<Future<void>>(() async {
    setup();
  }, FirebaseCrashlytics.instance.recordError);
}
