import 'package:chily_labs_assignment/components/fail_fetch_widget.dart';
import 'package:chily_labs_assignment/components/giphy_container_widget.dart';
import 'package:chily_labs_assignment/components/search_bar_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chily_labs_assignment/main.dart';

void main() {
  testWidgets('App essentials present', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    expect(find.byType(GiphySearchBar), findsOneWidget);

    expect(find.byType(GiphyContainer), findsOneWidget);
  });

  testWidgets('Failed GIF search simulation', (WidgetTester tester) async {
    await dotenv.load(fileName: '.env');

    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    await tester.tap(find.byType(SearchBar));

    // No matter the query, app during the test will receive
    // mocked up 400 response code.
    await tester.enterText(find.byType(SearchBar), "Dead Cells");

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(FailFetchComponent), findsOneWidget);
  });
}
