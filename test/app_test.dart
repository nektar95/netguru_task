import 'package:flutter_test/flutter_test.dart';
import 'package:netguru_task/app/app.dart';
import 'package:netguru_task/modules/home/ui/home_page.dart';

void main() {
  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
