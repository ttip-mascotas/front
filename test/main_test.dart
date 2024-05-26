import 'package:flutter_test/flutter_test.dart';
import 'package:mascotas/main.dart';

import 'datasource/pets_datasource_test.mocks.dart';

void main() {
  final MockNotifier notifier = MockNotifier();

  testWidgets("Hello Widget", (WidgetTester tester) async {
    await tester.pumpWidget(MainApp(
      notifier: notifier,
    ));
    await tester.pump();
    expect(find.text('Mis Mascotas'), findsOneWidget);
  });
}
