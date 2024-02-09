// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myfarm/features/authentication/presentation/login_page.dart';

import 'package:myfarm/main.dart';

void main() {
  testWidgets('LoginScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(child: const LoginPage()));

    // Verify that our counter starts at 0.
    expect(find.text('البريد الالكتروني'), findsOneWidget);
    expect(find.text('كلمة المرور'), findsOneWidget);
    final Widget myBtn =
        ElevatedButton(onPressed: () {}, child: Text('تسجيل الدخول'));
    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byWidget(myBtn));
    await tester.pump();

    // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
