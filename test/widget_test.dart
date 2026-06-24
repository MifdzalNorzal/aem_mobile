import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aem_mobile/app.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const DevCorpApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
