import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_task/base/exceptions/storage_exception.dart';
import 'package:netguru_task/base/exceptions/unknown_exception.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/modules/favorites/bloc/bloc.dart';
import 'package:netguru_task/modules/values/models/value.dart';
import 'package:netguru_task/modules/values/repository/values_repository.dart';
import 'package:netguru_task/modules/values/storage/values_storage.dart';

import 'mocks/firebase_mocks.dart';
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

  final valueFavortiteChanged = Value('Lorem ipsum', 1, true);

  final listFavorites = <Value>[valueFavortiteChanged];

  FavoritesBloc favoritesBloc;
  setUp(() {
    mockValuesRepository = MockValuesRepository();
    favoritesBloc = FavoritesBloc(
        firebaseCrashlytics: firebaseCrashlytics,
        valuesRepository: mockValuesRepository);
  });

  tearDown(() {
    favoritesBloc?.close();
  });

  test('FavoritesBloc initial state', () {
    expect(favoritesBloc.state, FavoritesInitState());
  });

  group('Get favorites values', () {
    blocTest('emits on FavoritesLoadedState - success',
        build: () {
          when(mockValuesRepository.getFavoritesValues())
              .thenAnswer((_) => Future<List<Value>>.value(listFavorites));

          return favoritesBloc;
        },
        act: (bloc) => bloc.add(GetFavoritesValuesData()),
        expect: [FavoritesLoadingState(), FavoritesLoadedState(listFavorites)]);

    blocTest('emits on FavoritesErrorState - fail',
        build: () {
          when(mockValuesRepository.getFavoritesValues())
              .thenThrow(UnknownErrorException());

          return favoritesBloc;
        },
        act: (bloc) => bloc.add(GetFavoritesValuesData()),
        expect: [
          FavoritesLoadingState(),
          FavoritesErrorState(ErrorCode.unexpected)
        ]);

    blocTest('emits on FavoritesErrorState - fail',
        build: () {
          when(mockValuesRepository.getFavoritesValues())
              .thenThrow(StorageException());

          return favoritesBloc;
        },
        act: (bloc) => bloc.add(GetFavoritesValuesData()),
        expect: [
          FavoritesLoadingState(),
          FavoritesErrorState(ErrorCode.storageError)
        ]);
  });

  group('Test home events', () {
    test('GetValuesData', () {
      expect(GetFavoritesValuesData().props, <Object>[]);
    });
  });

  ///repository tests

  group('Favorites values repository test', () {
    test('Get favorites values list success ', () async {
      const response =
          '[{\"text\":\"Lorem ipsum\",\"id\":1,\"favorite\":true},{\"text\":\"Lorem ipsum dura lex sed lex\",\"id\":2,\"favorite\":false}]';

      when(mockValuesStorage.getValuesRaw()).thenAnswer((_) async => response);

      final values = await valuesRepository.getFavoritesValues();
      expect(listEquals(values, listFavorites), isTrue);
    });

    test('Get favorites values list - fail', () async {
      const response = 'broken json';

      when(mockValuesStorage.getValuesRaw()).thenAnswer((_) async => response);

      valuesRepository.cachedValues = null;

      expect(valuesRepository.getFavoritesValues(),
          throwsA(const TypeMatcher<StorageException>()));
    });
  });
}
