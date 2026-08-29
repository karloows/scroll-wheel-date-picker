import 'package:flutter/material.dart'
    show MaterialApp, Scaffold, Colors, SizedBox, Row, Column, ShaderMask;
import 'package:flutter_test/flutter_test.dart'
    show
        testWidgets,
        expect,
        find,
        findsOneWidget,
        test,
        isFalse,
        isTrue,
        findsWidgets,
        findsNothing;
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart'
    show
        ScrollWheelDatePicker,
        CurveDatePickerTheme,
        FlatDatePickerTheme,
        DatePickerColumn,
        defaultOpacity;
import 'package:scroll_wheel_date_picker/src/widgets/flat_wheel_scroll_view.dart'
    show FlatWheelScrollView;
import 'package:flutter/material.dart' show ListWheelScrollView;

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

  test('flat theme defaults to no fade and full opacity', () {
    final theme = FlatDatePickerTheme(backgroundColor: Colors.transparent);
    expect(theme.fadeEdges, isFalse);
    expect(theme.overAndUnderCenterOpacity, 1.0);
  });

  test('flat theme retains explicit non-default values', () {
    final theme = FlatDatePickerTheme(
      backgroundColor: Colors.transparent,
      fadeEdges: true,
      overAndUnderCenterOpacity: 0.5,
    );
    expect(theme.fadeEdges, isTrue);
    expect(theme.overAndUnderCenterOpacity, 0.5);
  });

  test('curve theme defaults are unchanged', () {
    final theme = CurveDatePickerTheme();
    expect(theme.fadeEdges, isTrue);
    expect(theme.overAndUnderCenterOpacity, defaultOpacity);
  });

  testWidgets(
      'flat theme renders FlatWheelScrollView, never ListWheelScrollView', (
    tester,
  ) async {
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

    expect(find.byType(FlatWheelScrollView), findsWidgets);
    expect(find.byType(ListWheelScrollView), findsNothing);
  });

  testWidgets('flat mask uses custom wheelPickerHeight and itemExtent', (
    tester,
  ) async {
    const customHeight = 222.0;
    const customItemExtent = 77.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScrollWheelDatePicker(
            initialDate: DateTime(2024, 1, 1),
            theme: FlatDatePickerTheme(
              backgroundColor: Colors.black,
              wheelPickerHeight: customHeight,
              itemExtent: customItemExtent,
            ),
          ),
        ),
      ),
    );

    // Locate the mask's Column by its distinctive shape (Expanded, gap, Expanded)
    // rather than by ancestor type, since Flutter's own scrolling internals also
    // insert IgnorePointer widgets elsewhere in the tree.
    final maskColumnFinder = find.byWidgetPredicate(
      (widget) => widget is Column && widget.children.length == 3,
    );
    expect(maskColumnFinder, findsOneWidget);

    final gap = tester.widget<Column>(maskColumnFinder).children[1] as SizedBox;
    expect(gap.height, customItemExtent);

    final outerBox = tester.widget<SizedBox>(
      find
          .ancestor(of: maskColumnFinder, matching: find.byType(SizedBox))
          .first,
    );
    expect(outerBox.height, customHeight);
  });
}
