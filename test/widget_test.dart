import 'package:appdev_proj/screens/lists_page.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appdev_proj/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app with a valid boolean value for showIntro and trigger a frame.
    await tester.pumpWidget(MyApp(showIntro: false));

    // Verify the initial state of the app. For example, if showIntro is false,
    // ensure that the main page (e.g., ListPage) is displayed.
    expect(find.byType(ListPage), findsOneWidget);

    // Example assertions to check the initial state. Adjust these based on your app's UI.
    expect(find.text('Some text on the ListPage'), findsOneWidget);

    // Example of interacting with the widget if needed (e.g., tapping a button).
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Example of verifying changes or interactions.
    // expect(find.text('Updated text'), findsOneWidget);
  });
}
