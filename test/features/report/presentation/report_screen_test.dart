import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('report screen ...', (tester) async {
    // TODO: Implement test
    expect(find.byElementType(TabBar), findsOneWidget, skip: true);
    expect(find.text('تقرير الانتاج'), findsOneWidget);
  });
}
