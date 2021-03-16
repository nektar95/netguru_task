import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:meta/meta.dart';
import 'package:netguru_task/base/exceptions/storage_exception.dart';
import 'package:netguru_task/modules/values/models/value.dart';
import 'package:netguru_task/modules/values/storage/values_storage.dart';

class ValuesRepository {
  ValuesRepository(
      {@required this.firebaseCrashlytics, @required this.valuesStorage});

  final FirebaseCrashlytics firebaseCrashlytics;
  final ValuesStorage valuesStorage;

  List<Value> cachedValues;

  Future<List<Value>> getValues() async {
    try {
      if (cachedValues != null) {
        return cachedValues;
      }

      final result = <Value>[];
      var rawString = await valuesStorage.getValuesRaw();

      rawString ??= await createValues();

      for (final item in json.decode(rawString)) {
        result.add(Value.fromJson(item));
      }

      cachedValues = result;
      return result;
      // ignore: avoid_catches_without_on_clauses
    } catch (e, stackTrace) {
      await firebaseCrashlytics.recordError(e, stackTrace);
      throw StorageException();
    }
  }

  Future<List<Value>> getFavoritesValues() async {
    final list = await getValues();
    return list.where((element) => element.favorite).toList();
  }

  Future<List<Value>> changeValue(int id) async {
    final list = await getValues();
    list.firstWhere((element) => element.id == id).favorite = true;
    await saveValues(list);
    return list;
  }

  Future<void> saveValues(List<Value> list) async {
    try {
      cachedValues = list;
      await valuesStorage.saveValuesRaw(jsonEncode(list).toString());
      // ignore: avoid_catches_without_on_clauses
    } catch (e, stackTrace) {
      await firebaseCrashlytics.recordError(e, stackTrace);
      throw StorageException();
    }
  }

  Future<String> createValues() {
    return rootBundle.loadString('json/values.json');
  }
}
