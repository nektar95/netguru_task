import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_task/base/exceptions/unknown_exception.dart';
import 'package:netguru_task/modules/home/bloc/bloc.dart';
import 'package:netguru_task/modules/values/models/value.dart';
import 'package:netguru_task/modules/values/repository/values_repository.dart';

import 'mocks/firebase_mocks.dart';
import 'mocks/repositories.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ValuesRepository mockValuesRepository;
  final FirebaseCrashlytics firebaseCrashlytics = FirebaseCrashlyticsMock();

  final value = Value('Lorem ipsum', 1, false);
  final list = <Value>[value];

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

  group('Get values - success', () {
    blocTest('On success emits on HomeLoadedState',
        build: () {
          when(mockValuesRepository.getValues())
              .thenAnswer((_) => Future<List<Value>>.value(list));

          return homeBloc;
        },
        act: (bloc) => bloc.add(GetValuesData()),
        expect: [HomeLoadingState(), HomeLoadedState(list)]);
  });

  group('Get values - fail', () {
    blocTest('On success emits on HomeLoadedState',
        build: () {
          when(mockValuesRepository.getValues())
              .thenThrow(UnknownErrorException());

          return homeBloc;
        },
        act: (bloc) => bloc.add(GetValuesData()),
        expect: [HomeLoadingState(), HomeErrorState()]);
  });

  ///mode test

  test('Value', () {
    final valueTest =
        Value.fromJson({'text': 'Lorem ipsum', 'id': 1, 'favorite': false});

    expect(valueTest.text, isNotEmpty);
    expect(valueTest.id, 1);
    expect(valueTest.favorite, false);
  });
}
