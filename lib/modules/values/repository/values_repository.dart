import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:meta/meta.dart';
import 'package:netguru_task/base/exceptions/unknown_exception.dart';
import 'package:netguru_task/modules/values/models/value.dart';
import 'package:netguru_task/modules/values/storage/values_storage.dart';

class ValuesRepository {
  ValuesRepository(
      {@required this.firebaseCrashlytics, @required this.valuesStorage});

  final FirebaseCrashlytics firebaseCrashlytics;
  final ValuesStorage valuesStorage;

  Future<List<Value>> getValues() async {
    try {
      final rawString = await valuesStorage.getValuesRaw();

      var result = <Value>[];

      if (rawString != null) {
        for (final item in json.decode(rawString)) {
          result.add(Value.fromJson(item));
        }
      } else {
        result = createValues();
      }
      return result;
      // ignore: avoid_catches_without_on_clauses
    } catch (e, stackTrace) {
      await firebaseCrashlytics.recordError(e, stackTrace);
      throw UnknownErrorException();
    }
  }

  List<Value> createValues() {
    return [];
  }
}
