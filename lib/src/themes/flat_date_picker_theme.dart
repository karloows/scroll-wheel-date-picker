part of 'scroll_wheel_date_picker_theme.dart';

class FlatDatePickerTheme extends ScrollWheelDatePickerTheme {
  /// Theme for the `FlatScrollWheel`. [FlatScrollWheel]
  ///
  /// [wheelPickerHeight] Actual height of the [ScrollWheelDatePicker] widget. Defaults to [defaultWheelPickerHeight].
  ///
  /// [itemExtent] Maximum height of each [ScrollWheelDatePicker]'s items. Defaults to [defaultItemExtent].
  ///
  /// [overAndUnderCenterOpacity] Opacity of the items in the [ScrollWheelDatePicker] that are off centered.
  /// Defaults to `1.0` (fully opaque) so the flat picker has no dimming by default. Lower this to
  /// explicitly dim off-centered items.
  ///
  /// [monthFormat] Format of the month in the [ScrollWheelDatePicker]. Defaults to [MonthFormat.full].
  ///
  /// [locale] Locale used to translate month names. Defaults to `null` (English).
  ///
  /// [itemTextStyle] Text style of the items in the [ScrollWheelDatePicker]. Defaults to [defaultItemTextStyle].
  ///
  /// [overlay] Apply selected item's center overlay. Defaults to [ScrollWheelDatePickerOverlay.holo].
  ///
  /// [overlayColor] Selected item's center design color. Defaults to [Colors.black].
  ///
  /// [fadeEdges] Apply vertical faded-edges to smoothly transition overlapping items. Defaults to `false`
  /// so the flat picker has no edge fade. Set to `true` to explicitly opt into the softened wheel look.
  ///
  /// [backgroundColor] Overlay color of the [ScrollWheelDatePicker] items that are off centered. Defaults to [Colors.transparent].

  FlatDatePickerTheme({
    super.wheelPickerHeight,
    super.itemExtent,
    super.monthFormat,
    super.locale,
    super.overAndUnderCenterOpacity = 1.0,
    super.itemTextStyle,
    super.overlay,
    super.overlayColor,
    required this.backgroundColor,
    super.fadeEdges = false,
  });

  /// Overlay color of the [ScrollWheelDatePicker] items that are off centered. Defaults to [Colors.transparent].
  final Color backgroundColor;
}
