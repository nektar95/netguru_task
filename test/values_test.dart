import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_task/base/exceptions/storage_exception.dart';
import 'package:netguru_task/base/exceptions/unknown_exception.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/modules/home/bloc/bloc.dart';
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

  final value = Value('Lorem ipsum', 1, false);
  final valueFavortiteChanged = Value('Lorem ipsum', 1, true);
  final value1 = Value('Lorem ipsum dura lex sed lex', 2, false);
  final list = <Value>[value, value1];

  final listChanged = <Value>[valueFavortiteChanged, value1];

  HomeBloc homeBloc;
  setUp(() {
    mockValuesRepository = MockValuesRepository();
    homeBloc = HomeBloc(
        firebaseCrashlytics: firebaseCrashlytics,
        valuesRepository: mockValuesRepository);
  });

  tearDown(() {
    homeBloc?.close();
  });

  test('HomeBloc initial state', () {
    expect(homeBloc.state, HomeInitState());
  });

  group('Get values', () {
    blocTest('emits on HomeLoadedState - success',
        build: () {
          when(mockValuesRepository.getValues())
              .thenAnswer((_) => Future<List<Value>>.value(list));

          return homeBloc;
        },
        act: (bloc) => bloc.add(GetValuesData()),
        expect: [HomeLoadingState(), HomeLoadedState(list)]);

    blocTest('emits on HomeErrorState - fail',
        build: () {
          when(mockValuesRepository.getValues())
              .thenThrow(UnknownErrorException());

          return homeBloc;
        },
        act: (bloc) => bloc.add(GetValuesData()),
        expect: [HomeLoadingState(), HomeErrorState(ErrorCode.unexpected)]);

    blocTest('emits on HomeErrorState - fail',
        build: () {
          when(mockValuesRepository.getValues()).thenThrow(StorageException());

          return homeBloc;
        },
        act: (bloc) => bloc.add(GetValuesData()),
        expect: [HomeLoadingState(), HomeErrorState(ErrorCode.storageError)]);
  });

  group('Add value to favorites', () {
    blocTest('emits on HomeLoadedState - success',
        build: () {
          when(mockValuesRepository.changeValue(1))
              .thenAnswer((_) => Future<List<Value>>.value(listChanged));

          return homeBloc;
        },
        act: (bloc) => bloc.add(AddValueToFavorites(1)),
        expect: [HomeLoadedState(listChanged)]);

    blocTest('emits on HomeLoadedState - fail',
        build: () {
          when(mockValuesRepository.getValues())
              .thenThrow(UnknownErrorException());

          return homeBloc;
        },
        act: (bloc) => bloc.add(GetValuesData()),
        expect: [HomeLoadingState(), HomeErrorState(ErrorCode.unexpected)]);

    blocTest('emits on HomeLoadedState - fail',
        build: () {
          when(mockValuesRepository.getValues()).thenThrow(StorageException());

          return homeBloc;
        },
        act: (bloc) => bloc.add(GetValuesData()),
        expect: [HomeLoadingState(), HomeErrorState(ErrorCode.storageError)]);
  });

  group('Test home events', () {
    test('GetValuesData', () {
      expect(GetValuesData().props, <Object>[]);
    });
    test('AddValueToFavorites', () {
      expect(AddValueToFavorites(1).props, <Object>[1]);
    });
  });

  ///mode test

  test('Value', () {
    final valueTest =
        Value.fromJson({'text': 'Lorem ipsum', 'id': 1, 'favorite': false});

    expect(valueTest.text, isNotEmpty);
    expect(valueTest.id, 1);
    expect(valueTest.favorite, false);
  });

  ///repository tests

  group('values repository test', () {
    test('Get values list success ', () async {
      const response =
          '[{\"text\":\"Lorem ipsum\",\"id\":1,\"favorite\":false},{\"text\":\"Lorem ipsum dura lex sed lex\",\"id\":2,\"favorite\":false}]';

      when(mockValuesStorage.getValuesRaw()).thenAnswer((_) async => response);

      final values = await valuesRepository.getValues();
      expect(listEquals(values, list), isTrue);
    });

    test('Get values list - fail', () async {
      const response = 'broken json';

      when(mockValuesStorage.getValuesRaw()).thenAnswer((_) async => response);

      valuesRepository.cachedValues = null;

      expect(valuesRepository.getValues(),
          throwsA(const TypeMatcher<StorageException>()));
    });

    test('Add value to favorites ', () async {
      const response =
          '[{\"text\":\"Lorem ipsum\",\"id\":1,\"favorite\":false},{\"text\":\"Lorem ipsum dura lex sed lex\",\"id\":2,\"favorite\":false}]';

      when(mockValuesStorage.getValuesRaw()).thenAnswer((_) async => response);

      final values = await valuesRepository.changeValue(1);
      expect(listEquals(values, listChanged), isTrue);
    });

    test('Add value to favorites - remove value', () async {
      const response =
          '[{\"text\":\"Lorem ipsum\",\"id\":1,\"favorite\":true},{\"text\":\"Lorem ipsum dura lex sed lex\",\"id\":2,\"favorite\":false}]';

      when(mockValuesStorage.getValuesRaw()).thenAnswer((_) async => response);

      final values = await valuesRepository.changeValue(1);
      expect(listEquals(values, list), isTrue);
    });

    test('Add value to favorites - fail', () async {
      const response = 'broken json';

      when(mockValuesStorage.getValuesRaw()).thenAnswer((_) async => response);

      valuesRepository.cachedValues = null;

      expect(valuesRepository.changeValue(1),
          throwsA(const TypeMatcher<StorageException>()));
    });
  });
}
