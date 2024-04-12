import 'package:flutter_test/flutter_test.dart';
import 'package:mascotas/main.dart';

void main() {
  testWidgets("Hello Widget", (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pump();
    expect(find.text('Mis Mascotas'), findsOneWidget);
  });
}
