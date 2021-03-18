import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_task/base/ui/loading_widget.dart';
import 'package:netguru_task/l10n/l10n.dart';
import 'package:netguru_task/modules/add_value/bloc/add_value_bloc.dart';
import 'package:netguru_task/modules/add_value/bloc/bloc.dart';
import 'package:netguru_task/modules/add_value/ui/add_value_info.dart';
import 'package:netguru_task/modules/add_value/ui/add_value_input.dart';
import 'package:netguru_task/modules/add_value/ui/add_value_page.dart';
import 'package:netguru_task/modules/add_value/ui/add_value_text.dart';

import '../mocks/blocs.dart';

void main() {
  group('AddValuePage', () {
    AddValueBloc addValueBloc;

    setUp(() {
      addValueBloc = MockAddValueBloc();
    });

    testWidgets('AddValuePage saving value', (tester) async {
      when(addValueBloc.state).thenAnswer(
        (_) => AddValueSavingState(),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AddValueBloc>.value(value: addValueBloc),
          ],
          child: MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: AddValuePage(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('AddValuePage check ui', (tester) async {
      when(addValueBloc.state).thenAnswer(
        (_) => AddValueInitState(),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AddValueBloc>.value(value: addValueBloc),
          ],
          child: MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: AddValuePage(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(AddValueInfo), findsOneWidget);
      expect(find.byType(AddValueInput), findsOneWidget);
      expect(find.byType(AddValueText), findsOneWidget);
    });
  });
}
