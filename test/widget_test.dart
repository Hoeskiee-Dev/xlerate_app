import 'package:flutter_test/flutter_test.dart';

import 'package:learners_app/main.dart';

void main() {
  testWidgets('profile screen renders key content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('User Name'), findsOneWidget);
    expect(find.text('user@example.com'), findsOneWidget);
    expect(find.text('Activity'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });
}
