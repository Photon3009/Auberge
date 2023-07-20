// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:auberge/main.dart';
import 'package:auberge/view/email_auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

   testWidgets('Check for widget overflow in LoginScreen', (WidgetTester tester) async {
    // Ensure that the WidgetsBinding is initialized.
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.pumpWidget(
    
      LoginScreen(),
    
    );

    // Get the size of the LoginScreen widget
    final RenderBox renderBox = tester.renderObject(find.byType(LoginScreen));
    final Size widgetSize = renderBox.size;
    final Size screenSize = tester.binding.window.physicalSize / tester.binding.window.devicePixelRatio;

    // Check if the widget overflows the screen
    if (widgetSize.width > screenSize.width || widgetSize.height > screenSize.height) {
      fail('LoginScreen widget is overflowing the screen.');
    }
  });
  //  testWidgets('Check for widget overflow', (WidgetTester tester) async {
  //   await tester.pumpWidget(MyApp());

  //   // Get all routes in the app
  //    final List routes = tester.allElements.whereType<Route>().map((element) => element).toList();

  //   // Loop through each route and check for overflow
  //   for (final route in routes) {
  //     await tester.pumpAndSettle(route.duration);

  //     // Check if any widget overflows the screen
  //     final RenderBox renderBox = tester.renderObject(find.byType(route.widget.runtimeType));
  //     final Size widgetSize = renderBox.size;
  //     final Size screenSize = tester.binding.window.physicalSize / tester.binding.window.devicePixelRatio;
      
  //     if (widgetSize.width > screenSize.width || widgetSize.height > screenSize.height) {
  //       fail('Widget ${route.widget.runtimeType} is overflowing the screen.');
  //     }
  //   }
  // });
}
