import 'package:flutter_test/flutter_test.dart';

import 'package:zinetravel/src/app.dart';

void main() {
  testWidgets('App renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const SkyFlightMcrApp());
    await tester.pump();

    // Verify the app renders the top bar navigation
    expect(find.text('Zine Travel'), findsWidgets);
  });
}
