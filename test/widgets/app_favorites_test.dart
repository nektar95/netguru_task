import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/base/ui/failure_widget.dart';
import 'package:netguru_task/base/ui/loading_widget.dart';
import 'package:netguru_task/l10n/l10n.dart';
import 'package:netguru_task/modules/favorites/bloc/bloc.dart';
import 'package:netguru_task/modules/favorites/ui/favorites_list.dart';
import 'package:netguru_task/modules/favorites/ui/favorites_list_empty.dart';
import 'package:netguru_task/modules/favorites/ui/favorites_page.dart';
import 'package:netguru_task/modules/values/models/value.dart';

import '../mocks/blocs.dart';

void main() {
  final value = Value('Lorem ipsum', 1, true);
  final value1 = Value('Lorem ipsum dura lex sed lex', 2, true);
  final list = <Value>[value, value1];

  group('Favorites', () {
    FavoritesBloc favoritesBloc;

    setUp(() {
      favoritesBloc = MockFavoritesBloc();
    });

    testWidgets('FavoritesPage loading', (tester) async {
      when(favoritesBloc.state).thenAnswer(
        (_) => FavoritesLoadingState(),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<FavoritesBloc>.value(value: favoritesBloc),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: FavoritesPage(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('FavoritesPage error', (tester) async {
      when(favoritesBloc.state).thenAnswer(
        (_) => FavoritesErrorState(ErrorCode.storageError),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<FavoritesBloc>.value(value: favoritesBloc),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: FavoritesPage(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(FailureWidget), findsOneWidget);
    });

    testWidgets('FavoritesPage loaded', (tester) async {
      when(favoritesBloc.state).thenAnswer(
        (_) => FavoritesLoadedState(list),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<FavoritesBloc>.value(value: favoritesBloc),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: FavoritesPage(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(FavoritesList), findsOneWidget);
    });

    testWidgets('FavoritesPage loaded empty', (tester) async {
      when(favoritesBloc.state).thenAnswer(
        (_) => FavoritesLoadedState([]),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<FavoritesBloc>.value(value: favoritesBloc),
          ],
          child: MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: FavoritesPage(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(FavoritesListEmpty), findsOneWidget);
    });
  });
}
