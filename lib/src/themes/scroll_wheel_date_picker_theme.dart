import 'package:flutter/material.dart' show TextStyle, Color, Locale, Colors;

import '../widgets/scroll_wheel_date_picker.dart' show ScrollWheelDatePicker;
import '../widgets/curve_scroll_wheel.dart' show CurveScrollWheel;
import '../constants/theme_constants.dart'
    show
        defaultWheelPickerHeight,
        defaultItemExtent,
        defaultOpacity,
        defaultItemTextStyle,
        ScrollWheelDatePickerOverlay,
        defaultDiameterRatio;
import '../widgets/flat_scroll_wheel.dart' show FlatScrollWheel;
import '../constants/date_constants.dart' show MonthFormat;

part 'curve_date_picker_theme.dart';
part 'flat_date_picker_theme.dart';

abstract class ScrollWheelDatePickerTheme {
  /// An abstract class for common themes of the `ScrollWheelDatePicker`. [ScrollWheelDatePicker]
  ///
  /// [wheelPickerHeight] Actual height of the [ScrollWheelDatePicker] widget. Defaults to [defaultWheelPickerHeight].
  ///
  /// [itemExtent] Maximum height of each [ScrollWheelDatePicker]'s items. Defaults to [defaultItemExtent].
  ///
  /// [overAndUnderCenterOpacity] Opacity of the items in the [ScrollWheelDatePicker] that are off centered. Defaults to [defaultOpacity].
  ///
  /// [monthFormat] Format of the month in the [ScrollWheelDatePicker]. Defaults to [MonthFormat.full].
  ///
  /// [locale] Locale used to translate month names. Defaults to `null` (English).
  ///
  /// [itemTextStyle] Text style of the items in the [ScrollWheelDatePicker]. Defaults to [defaultItemTextStyle].
  ///
  /// [overlay] Apply selected item's center overlay. Defaults to [ScrollWheelDatePickerOverlay.holo].
  ///
  /// [overlayColor] Selected item's center design color.
  ///
  /// [fadeEdges] Apply vertical faded-edges to smoothly transition overlapping items. Defaults to `true`.
  ScrollWheelDatePickerTheme({
    this.wheelPickerHeight = defaultWheelPickerHeight,
    this.itemExtent = defaultItemExtent,
    this.overAndUnderCenterOpacity = defaultOpacity,
    this.monthFormat = MonthFormat.full,
    this.locale,
    this.itemTextStyle,
    this.overlay = ScrollWheelDatePickerOverlay.holo,
    this.overlayColor,
    this.fadeEdges = true,
  });

  /// Actual height of the [ScrollWheelDatePicker] widget. Defaults to [defaultWheelPickerHeight].
  final double wheelPickerHeight;

  /// Maximum height of each [ScrollWheelDatePicker]'s items. Defaults to [defaultItemExtent].
  final double itemExtent;

  /// Opacity of the items in the [ScrollWheelDatePicker] that are off centered. Defaults to [defaultOpacity].
  final double overAndUnderCenterOpacity;

  /// Format of the month in the [ScrollWheelDatePicker]. Defaults to [MonthFormat.full].
  ///
  /// [MonthFormat.full] - Shows the full name of the month.
  ///
  /// [MonthFormat.threeLetters] - Shows the three letters abbreviations of the month.
  ///
  /// [MonthFormat.twoLetters] - Shows the two letters abbreviations of the month.
  final MonthFormat monthFormat;

  /// Locale used to translate month names when [monthFormat] renders text. Defaults to `null` (English).
  ///
  /// Requires the app to have called `initializeDateFormatting()` (from `package:intl/date_symbol_data_local.dart`)
  /// for this locale before building the picker, otherwise `intl` throws a `LocaleDataException`.
  ///
  /// [MonthFormat.twoLetters] combined with a [locale] takes the first two characters of the localized
  /// abbreviation and may collide between different months in some languages — use [MonthFormat.threeLetters]
  /// for guaranteed uniqueness.
  final Locale? locale;

  /// Text style of the items in the [ScrollWheelDatePicker]. Defaults to [defaultItemTextStyle].
  final TextStyle? itemTextStyle;

  /// Apply selected item's center overlay. Defaults to [ScrollWheelDatePickerOverlay.holo].
  final ScrollWheelDatePickerOverlay overlay;

  /// Selected item's center overlay color.
  ///
  /// If overlay is [ScrollWheelDatePickerOverlay.holo] then this defaults to [Colors.white].
  ///
  /// If overlay is [ScrollWheelDatePickerOverlay.highlight] then this defaults to [Colors.grey] with an opacity of `0.1`.
  ///
  /// If overlay is [ScrollWheelDatePickerOverlay.line] then this defaults to [Colors.white].
  final Color? overlayColor;

  /// Apply vertical faded-edges to smoothly transition overlapping items. Defaults to `true`.
  final bool fadeEdges;
}
