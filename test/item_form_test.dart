// test/item_form_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_project_name/screens/item_form.dart';

void main() {
  testWidgets('Item form loads correctly', (WidgetTester tester) async {
    // Build the ItemForm widget
    await tester.pumpWidget(MaterialApp(home: ItemForm()));

    // Verify if the form's input fields are present
    expect(find.byType(TextFormField), findsNWidgets(2)); // Name and Quantity fields
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Quantity'), findsOneWidget);

    // Verify the 'Create' button is present
    expect(find.text('Create'), findsOneWidget);
  });
}
