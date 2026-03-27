import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bottom_nav_lab/main.dart'; // 1. Updated package name

void main() {
  testWidgets('Bottom navigation smoke test', (
    WidgetTester tester,
  ) async {
    // 2. Build our app and trigger a frame.
    await tester.pumpWidget(const BottomNavApp());

    // 3. Verify that our Home screen is showing.
    // In our new code, the Home screen shows "Home Screen"
    expect(
      find.text('Home Screen'),
      findsOneWidget,
    );

    // 4. Tap the 'Search' tab.
    // We use byIcon to find the search icon in the bottom bar
    await tester.tap(find.byIcon(Icons.search));

    // pump() tells the test to re-render the screen after the tap
    await tester.pump();

    // 5. Verify that the text changed to the Search Screen text.
    expect(
      find.text('Search Screen'),
      findsOneWidget,
    );

    // 6. Tap the 'Profile' tab.
    await tester.tap(find.byIcon(Icons.person));
    await tester.pump();

    expect(
      find.text('Profile Screen'),
      findsOneWidget,
    );
  });
}
