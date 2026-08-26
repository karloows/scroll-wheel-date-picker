import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';

void main() {
  testWidgets('ScrollWheelDatePicker renders with curve theme', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScrollWheelDatePicker(
            initialDate: DateTime(2024, 1, 1),
            theme: CurveDatePickerTheme(),
          ),
        ),
      ),
    );

    expect(find.byType(ScrollWheelDatePicker), findsOneWidget);
  });

  testWidgets('ScrollWheelDatePicker renders with flat theme', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScrollWheelDatePicker(
            initialDate: DateTime(2024, 1, 1),
            theme: FlatDatePickerTheme(backgroundColor: Colors.transparent),
          ),
        ),
      ),
    );

    expect(find.byType(ScrollWheelDatePicker), findsOneWidget);
  });

  testWidgets('columnOrder controls the left-to-right wheel order', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScrollWheelDatePicker(
            initialDate: DateTime(2024, 1, 1),
            theme: CurveDatePickerTheme(),
            columnOrder: const [
              DatePickerColumn.month,
              DatePickerColumn.day,
              DatePickerColumn.year,
            ],
          ),
        ),
      ),
    );

    final row = tester.widget<Row>(
      find.descendant(of: find.byType(ShaderMask), matching: find.byType(Row)),
    );
    expect(row.children.length, 3);
  });
}
