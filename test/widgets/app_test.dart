import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netguru_task/app/app.dart';
import 'package:netguru_task/modules/home/ui/home_screen.dart';
import 'package:netguru_task/modules/values/ui/values_page.dart';
import 'package:netguru_task/utility/flavors.dart';

import '../mocks/firebase_mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();

  setUp(() async {
    setAppFlavor(Flavor.dev);
    await Firebase.initializeApp();
  });

  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(const App());

      await tester.idle();
      await tester.pump(Duration.zero);

      expect(find.byType(HomeScreen), findsOneWidget);

      expect(
          find.byType(
            ConvexAppBar,
          ),
          findsOneWidget);

      ///check bottom navigation
      expect(find.byIcon(Icons.format_quote_sharp), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);

      expect(find.byType(ValuesPage), findsOneWidget);
    });
  });
}
