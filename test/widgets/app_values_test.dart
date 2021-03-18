import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/base/ui/failure_widget.dart';
import 'package:netguru_task/base/ui/loading_widget.dart';
import 'package:netguru_task/modules/home/bloc/bloc.dart';
import 'package:netguru_task/modules/values/models/value.dart';
import 'package:netguru_task/modules/values/ui/values_container.dart';
import 'package:netguru_task/modules/values/ui/values_page.dart';

import '../mocks/blocs.dart';

void main() {
  final value = Value('Lorem ipsum', 1, false);
  final value1 = Value('Lorem ipsum dura lex sed lex', 2, false);
  final list = <Value>[value, value1];

  group('Values', () {
    HomeBloc homeBloc;

    setUp(() {
      homeBloc = MockHomeBloc();
    });

    testWidgets('ValuesPage loading', (tester) async {
      when(homeBloc.state).thenAnswer(
        (_) => HomeLoadingState(),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>.value(value: homeBloc),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ValuesPage(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('ValuesPage error', (tester) async {
      when(homeBloc.state).thenAnswer(
        (_) => HomeErrorState(ErrorCode.storageError),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>.value(value: homeBloc),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ValuesPage(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(FailureWidget), findsOneWidget);
    });

    testWidgets('ValuesPage loaded', (tester) async {
      when(homeBloc.state).thenAnswer(
        (_) => HomeLoadedState(list),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>.value(value: homeBloc),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ValuesPage(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(ValuesContainer), findsOneWidget);
    });
  });
}
