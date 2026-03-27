import 'package:flutter_test/flutter_test.dart';
import 'package:profile_card_lab/main.dart'; // Make sure this matches your project name

void main() {
  testWidgets('Profile Card smoke test', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProfileCardApp(),
    );

    // Verify that our developer name appears on the screen.
    expect(
      find.text('Alex Johnson'),
      findsOneWidget,
    );

    // Verify that the "My Profile" title is in the AppBar.
    expect(
      find.text('My Profile'),
      findsOneWidget,
    );
  });
}
