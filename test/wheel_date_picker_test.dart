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

  test('changeYear resolves the leap-year day count by calendar year', () {
    final controller = DateController(initialDate: DateTime(1999, 2, 1));

    // The years wheel is index-based (0 = start year), so the array index
    // for year 2000 does not equal 2000 itself — verifies the day count is
    // computed from the resolved calendar year, not the raw wheel index.
    final yearIndex = controller.yearController.items.indexOf('2000');
    controller.changeYear(year: yearIndex);
    controller.changeMonth(month: DateTime.february - 1);

    expect(controller.dayController.items.length, 29);
  });

  test('constructing with an initialDate in December does not throw', () {
    // Regression test for https://github.com/karloows/scroll-wheel-date-picker/issues/9 —
    // month was passed 1-indexed into the 0-indexed days-per-month lookup,
    // so December (12) read past the end of the list.
    final controller = DateController(initialDate: DateTime(2024, 12, 24));

    expect(controller.dayController.items.length, 31);
  });
}
