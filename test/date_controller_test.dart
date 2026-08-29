import 'package:flutter/material.dart' show Locale;
import 'package:flutter_test/flutter_test.dart'
    show test, expect, TestWidgetsFlutterBinding, group, isA, throwsA, setUpAll;
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart'
    show DateController, MonthFormat;

void main() {
  // `changeMonth`/`changeYear` defer their notifyListeners to a
  // post-frame callback via WidgetsBinding, which needs the test binding
  // initialized even though these are plain `test()`s, not `testWidgets()`.
  TestWidgetsFlutterBinding.ensureInitialized();

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

  test('changeInitialDate to December does not throw', () {
    // Regression test: changeInitialDate had the same 1-indexed-month bug
    // as the constructor (see https://github.com/karloows/scroll-wheel-date-picker/issues/9).
    final controller = DateController(initialDate: DateTime(2024, 1, 1));

    controller.changeInitialDate(DateTime(2024, 12, 24));

    expect(controller.dayController.items.length, 31);
  });

  group('leap year day counts', () {
    test('divisible by 4, not by 100 -> leap (2024)', () {
      final controller = DateController(initialDate: DateTime(2024, 1, 1));
      controller.changeMonth(month: DateTime.february - 1);
      expect(controller.dayController.items.length, 29);
    });

    test('divisible by 100, not by 400 -> not leap (1900)', () {
      final controller = DateController(
        initialDate: DateTime(1901, 1, 1),
        startDate: DateTime(1899, 1, 1),
      );
      final yearIndex = controller.yearController.items.indexOf('1900');
      controller.changeYear(year: yearIndex);
      controller.changeMonth(month: DateTime.february - 1);
      expect(controller.dayController.items.length, 28);
    });

    test('divisible by 400 -> leap (2000)', () {
      final controller = DateController(initialDate: DateTime(1999, 2, 1));
      final yearIndex = controller.yearController.items.indexOf('2000');
      controller.changeYear(year: yearIndex);
      controller.changeMonth(month: DateTime.february - 1);
      expect(controller.dayController.items.length, 29);
    });

    test('not divisible by 4 -> not leap (2023)', () {
      final controller = DateController(initialDate: DateTime(2023, 1, 1));
      controller.changeMonth(month: DateTime.february - 1);
      expect(controller.dayController.items.length, 28);
    });
  });

  test(
      'switching from a 31-day month to a shorter month clamps the selected day',
      () {
    final controller = DateController(initialDate: DateTime(2024, 1, 31));

    controller.changeMonth(month: DateTime.april - 1);

    expect(controller.dayController.items.length, 30);
    expect(controller.dayController.selectedIndex, 29);
  });

  test('switching to February clamps day 31 down to the leap-year day count',
      () {
    final controller = DateController(initialDate: DateTime(2024, 1, 31));

    controller.changeMonth(month: DateTime.february - 1);

    expect(controller.dayController.items.length, 29);
    expect(controller.dayController.selectedIndex, 28);
  });

  test('constructing with startDate after lastDate throws', () {
    expect(
      () => DateController(
        startDate: DateTime(2024, 12, 31),
        lastDate: DateTime(2024, 1, 1),
      ),
      throwsA(isA<AssertionError>()),
    );
  });

  test('constructing with initialDate before startDate throws', () {
    expect(
      () => DateController(
        startDate: DateTime(2024, 6, 1),
        initialDate: DateTime(2024, 1, 1),
      ),
      throwsA(isA<AssertionError>()),
    );
  });

  test('constructing with initialDate after lastDate throws', () {
    expect(
      () => DateController(
        lastDate: DateTime(2024, 1, 1),
        initialDate: DateTime(2024, 6, 1),
      ),
      throwsA(isA<AssertionError>()),
    );
  });

  test('changeInitialDate before startDate throws', () {
    final controller = DateController(
      startDate: DateTime(2024, 1, 1),
      initialDate: DateTime(2024, 6, 1),
    );

    expect(
      () => controller.changeInitialDate(DateTime(2023, 1, 1)),
      throwsA(isA<AssertionError>()),
    );
  });

  test('changeStartDate after lastDate throws', () {
    final controller = DateController(initialDate: DateTime(2024, 6, 1));

    expect(
      () => controller.changeStartDate(DateTime(2100, 1, 1)),
      throwsA(isA<AssertionError>()),
    );
  });

  test('changeLastDate before startDate throws', () {
    final controller = DateController(initialDate: DateTime(2024, 6, 1));

    expect(
      () => controller.changeLastDate(DateTime(1900, 1, 1)),
      throwsA(isA<AssertionError>()),
    );
  });

  test('changeYear at year boundary updates startMonth/startDay bounds', () {
    final controller = DateController(
      startDate: DateTime(2024, 6, 15),
      initialDate: DateTime(2025, 1, 1),
    );

    // Selecting the start year should re-derive the start month/day bounds;
    // moving away from it should clear them.
    final startYearIndex = controller.yearController.items.indexOf('2024');
    controller.changeYear(year: startYearIndex);
    expect(controller.startMonth, DateTime.june - 1);

    final otherYearIndex = controller.yearController.items.indexOf('2030');
    controller.changeYear(year: otherYearIndex);
    expect(controller.startMonth, null);
    expect(controller.startDay, null);
  });

  group('locale', () {
    setUpAll(() async {
      await initializeDateFormatting('es');
    });

    test('locale: null keeps the default English month names', () {
      final controller = DateController(initialDate: DateTime(2024, 1, 1));

      expect(controller.monthController.items.first, 'January');
    });

    test('locale is applied on construction, not just after an update', () {
      // Regression test: `monthFormat`/`locale` used to only take effect via
      // a later `changeMonthFormat` call — the initial `_MonthController`
      // always built with English defaults regardless of what the caller
      // passed in, so a locale set once (the common case) never applied.
      final controller = DateController(
        initialDate: DateTime(2024, 1, 1),
        locale: const Locale('es'),
      );

      expect(controller.monthController.items.first, 'enero');
    });

    test('twoLetters with a locale returns 2-character strings', () {
      final controller = DateController(
        initialDate: DateTime(2024, 1, 1),
        monthFormat: MonthFormat.twoLetters,
        locale: const Locale('es'),
      );

      expect(
          controller.monthController.items.every((m) => m.length == 2), true);
    });
  });
}
