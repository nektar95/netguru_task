import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:netguru_task/app/app.dart';
import 'package:netguru_task/app/app_bloc_observer.dart';
import 'package:netguru_task/utility/flavors.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  setAppFlavor(Flavor.dev);
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(const App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
