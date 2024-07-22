// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chily_labs_assignment/main.dart';

void main() {
  testWidgets('Basic GIF Search', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    await tester.tap(find.byType(SearchBar));
    await tester.enterText(find.byType(SearchBar), "Dead Cells");

    await tester.pump(const Duration(milliseconds: 2500));

    expect(find.byWidget(OrientationBuilder(
      builder: (context, orientation) {
        return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2));
      },
    )), findsOneWidget);
  });
}
