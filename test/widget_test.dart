import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:foodapp/app/food_app_root.dart';

void main() {
  testWidgets('App builds MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodAppRoot());
    await tester.pump();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
