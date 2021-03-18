import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_task/base/exceptions/storage_exception.dart';
import 'package:netguru_task/base/exceptions/unknown_exception.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/modules/add_value/bloc/add_value_bloc.dart';
import 'package:netguru_task/modules/add_value/bloc/bloc.dart';
import 'package:netguru_task/modules/values/models/value.dart';
import 'package:netguru_task/modules/values/repository/values_repository.dart';
import 'package:netguru_task/modules/values/storage/values_storage.dart';

import 'mocks/firebase_crashlytics.dart';
import 'mocks/repositories.dart';
import 'mocks/storages.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ValuesRepository mockValuesRepository;
  final ValuesStorage mockValuesStorage = MockValuesStorage();
  final FirebaseCrashlytics firebaseCrashlytics = FirebaseCrashlyticsMock();

  final valuesRepository = ValuesRepository(
      firebaseCrashlytics: firebaseCrashlytics,
      valuesStorage: mockValuesStorage);

  const newValueText = 'Audaces fortuna iuvat timidosque repellit';

  final value = Value('Lorem ipsum', 1, false);
  final value1 = Value('Lorem ipsum dura lex sed lex', 2, false);
  final newValue = Value(newValueText, 3, false);
  final addValuelist = <Value>[value, value1, newValue];

  AddValueBloc addValueBloc;
  setUp(() {
    mockValuesRepository = MockValuesRepository();
    addValueBloc = AddValueBloc(
        firebaseCrashlytics: firebaseCrashlytics,
        valuesRepository: mockValuesRepository);
  });

  tearDown(() {
    addValueBloc?.close();
  });

  test('AddValueBloc initial state', () {
    expect(addValueBloc.state, AddValueInitState());
  });

  group('Add value', () {
    blocTest('emits on HomeLoadedState - success',
        build: () {
          return addValueBloc;
        },
        act: (bloc) => bloc.add(AddNewValue(newValueText)),
        expect: [AddValueSavingState(), AddValueSavedState()]);

    blocTest('emits on AddValueErrorState - fail',
        build: () {
          when(mockValuesRepository.addNewValue(any))
              .thenThrow(UnknownErrorException());

          return addValueBloc;
        },
        act: (bloc) => bloc.add(AddNewValue(newValueText)),
        expect: [
          AddValueSavingState(),
          AddValueErrorState(ErrorCode.unexpected)
        ]);

    blocTest('emits on AddValueErrorState StorageException - fail',
        build: () {
          when(mockValuesRepository.addNewValue(any))
              .thenThrow(StorageException());

          return addValueBloc;
        },
        act: (bloc) => bloc.add(AddNewValue(newValueText)),
        expect: [
          AddValueSavingState(),
          AddValueErrorState(ErrorCode.storageError)
        ]);

    blocTest('emits on AddValueInitState - reset',
        build: () {
          return addValueBloc;
        },
        act: (bloc) => bloc.add(ResetAddValue()),
        expect: [AddValueInitState()]);
  });

  group('Test home events', () {
    test('GetValuesData', () {
      expect(ResetAddValue().props, <Object>[]);
    });
    test('AddValueToFavorites', () {
      expect(AddNewValue(newValueText).props, <Object>[newValueText]);
    });
  });

  ///repository tests

  group('Add value repository test', () {
    test('Add new value success ', () async {
      const response =
          '[{\"text\":\"Lorem ipsum\",\"id\":1,\"favorite\":false},{\"text\":\"Lorem ipsum dura lex sed lex\",\"id\":2,\"favorite\":false}]';

      when(mockValuesStorage.getValuesRaw()).thenAnswer((_) async => response);

      final values = await valuesRepository.addNewValue(newValueText);
      expect(listEquals(values, addValuelist), isTrue);
    });

    test('Add new value - fail', () async {
      const response = 'broken json';

      when(mockValuesStorage.getValuesRaw()).thenAnswer((_) async => response);

      valuesRepository.cachedValues = null;

      expect(valuesRepository.addNewValue(newValueText),
          throwsA(const TypeMatcher<StorageException>()));
    });
  });
}
