import 'package:flutter_test/flutter_test.dart';
import 'package:logoterapija/app.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(const LogotherapyLevelsApp());
    expect(find.text('Logoterapija • Leveli'), findsOneWidget);
  });
}
