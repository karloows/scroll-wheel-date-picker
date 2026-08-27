# Scroll Wheel Date Picker

[![pub package](https://img.shields.io/pub/v/scroll_wheel_date_picker.svg)](https://pub.dev/packages/scroll_wheel_date_picker)
[![license](https://img.shields.io/github/license/karloows/scroll-wheel-date-picker)](LICENSE)

Have you been in a situation where you want to use [CupertinoDatePicker](https://api.flutter.dev/flutter/cupertino/CupertinoDatePicker-class.html) but sadly you can't achieve a flat scroll view just like in android TikTok?
Or maybe, you also resorted using [ListWheelScrollView](https://api.flutter.dev/flutter/widgets/ListWheelScrollView-class.html) yet still the same?

#### Good news!

This package supports a wheel-type date-picker that has two scroll types: [CurveScrollWheel](https://github.com/karloows/scroll-wheel-date-picker/blob/main/lib/src/widgets/curve_scroll_wheel.dart) and [FlatScrollWheel](https://github.com/karloows/scroll-wheel-date-picker/blob/main/lib/src/widgets/flat_scroll_wheel.dart).

## Features

`ScrollWheelDatePicker` uses `ListWheelScrollView` for the `CurveScrollWheel` underneath. However, some features were added and modified in order to have the same functionality but without the curve perspective in `FlatScrollWheel`.

#### Centered Selected Item

Just like using `CupertinoDatePicker` or `ListWheelScrollView`, it allows you to select a date and expects that a particular item will always land on the center of the viewport.

#### Choose Center Overlay

You can choose what type of overlay you want to have on the current selected item. `holo`, `highlight`, and `line` are some of the overlays to choose for. If you don't want any overlays you can just set it to `none`. (Expect additional overlays or the option to add your own soon..)

#### Month Format

It allows you to select what type of month format you want to display. The available formats are `full` which simply means the complete name of the month, `threeLetters` and `twoLetters` basically formats the months based on their common abbreviations with the letter count.

#### Locale

Pass a `locale` to the theme to translate month names via [`intl`](https://pub.dev/packages/intl) instead of the default English names:

```dart
CurveDatePickerTheme(
  monthFormat: MonthFormat.full,
  locale: const Locale('es'), // enero, febrero, marzo...
)
```

`locale` defaults to `null` (English). For any other locale, your app must call `initializeDateFormatting()` (from `package:intl/date_symbol_data_local.dart`) for that locale before building the picker, otherwise `intl` throws. Note that `MonthFormat.twoLetters` combined with a `locale` takes the first two characters of the localized abbreviation and may collide between different months in some languages — use `threeLetters` for guaranteed uniqueness.

#### Faded Vertical Edges

It adds fade on top and bottom to create a smooth disappearance effect when the items are beyond the viewport. Defaults to `true` for `CurveDatePickerTheme`, and `false` for `FlatDatePickerTheme` (so the flat picker has no edge fade out of the box). Pass `fadeEdges: true` and lower `overAndUnderCenterOpacity` (which defaults to `1.0` on the flat theme) to opt into the softened, curve-like look on a flat picker.

#### Listen On Item Changes After Animation Completed

Unlike `CupertinoDatePicker`, it gives you an option whether to listen to item changes only after the scroll animation ended/completed. `listenAfterChanges` defaults to true, otherwise, change to false to have the default functionality.

#### Infinite Loop

Supports looping on items. You can choose whether to enable looping on `days`, `months` or `years` individually.

## Demo

### Flat Scroll Wheel

|    Flat Holo Overlay    |    Flat Highlight Overlay    |    Flat Line Overlay    |
| :---------------------: | :--------------------------: | :---------------------: |
| ![](demo/flat_holo.gif) | ![](demo/flat_highlight.gif) | ![](demo/flat_line.gif) |

### Curve Scroll Wheel

|               Curve Holo Overlay                |                  Curve Highlight Overlay                  |               Curve Line Overlay                |
| :---------------------------------------------: | :-------------------------------------------------------: | :---------------------------------------------: |
| ![Curve holo overlay demo](demo/curve_holo.gif) | ![Curve highlight overlay demo](demo/curve_highlight.gif) | ![Curve line overlay demo](demo/curve_line.gif) |

## Usage

Add the package to `pubspec.yaml`

```bash
$ flutter pub add scroll_wheel_date_picker
```

or

```yaml
dependencies:
  scroll_wheel_date_picker: ^0.1.2 # x-release-please-version
```

Then import the package.

```dart
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
```

Here is an example with bounds, callback, custom column order, and the flat wheel theme:

```dart
class BirthdayPicker extends StatefulWidget {
  const BirthdayPicker({super.key});

  @override
  State<BirthdayPicker> createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  DateTime selectedDate = DateTime(2000, 6, 15);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: ScrollWheelDatePicker(
            initialDate: selectedDate,
            startDate: DateTime(1950, 1, 1),
            lastDate: DateTime(today.year, today.month, today.day),
            loopDays: true,
            loopMonths: true,
            loopYears: false,
            listenAfterAnimation: true,
            columnOrder: const [
              DatePickerColumn.month,
              DatePickerColumn.day,
              DatePickerColumn.year,
            ],
            onSelectedItemChanged: (value) {
              setState(() => selectedDate = value);
            },
            theme: FlatDatePickerTheme(
              backgroundColor: Colors.white,
              overlay: ScrollWheelDatePickerOverlay.holo,
              itemTextStyle: defaultItemTextStyle.copyWith(
                color: Colors.black,
              ),
              overlayColor: Colors.black,
              monthFormat: MonthFormat.threeLetters,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('Selected: $selectedDate'),
      ],
    );
  }
}
```

`FlatDatePickerTheme` renders fully flat by default: no edge fade, off-center items at full opacity. To opt into the softened, curve-like dimming instead:

```dart
ScrollWheelDatePicker(
  theme: FlatDatePickerTheme(
    backgroundColor: Colors.white,
    fadeEdges: true,
    overAndUnderCenterOpacity: 0.2,
  ),
),
```

### Main options

| Property | Type | Default | Notes |
| :------- | :--- | :------ | :---- |
| `initialDate` | `DateTime?` | `DateTime.now()` | Initial selected date. |
| `startDate` | `DateTime?` | `0001-01-01` | Lower selection bound. |
| `lastDate` | `DateTime?` | `9999-12-31` | Upper selection bound. |
| `loopDays` | `bool` | `true` | Loops the day wheel. |
| `loopMonths` | `bool` | `true` | Loops the month wheel. |
| `loopYears` | `bool` | `false` | Year looping is off by default. |
| `listenAfterAnimation` | `bool` | `true` | Fires the callback after the wheel settles. |
| `onSelectedItemChanged` | `Function(DateTime value)?` | `null` | Receives the selected date. |
| `columnOrder` | `List<DatePickerColumn>` | `[day, month, year]` | Reorders the three wheels left-to-right. |
| `scrollBehavior` | `ScrollBehavior?` | `null` | Optional scroll behavior override. |
| `theme` | `ScrollWheelDatePickerTheme` | required | Use `FlatDatePickerTheme` or `CurveDatePickerTheme`. |

### Theme options

| Property | Applies to | Default | Notes |
| :------- | :--------- | :------ | :---- |
| `wheelPickerHeight` | both | package default | Overall picker height. |
| `itemExtent` | both | package default | Height of each visible row. |
| `monthFormat` | both | `MonthFormat.full` | `full`, `threeLetters`, or `twoLetters`. |
| `locale` | both | `null` | Uses localized month names through `intl`. |
| `itemTextStyle` | both | package default | Style for visible items. |
| `overlay` | both | `holo` | Selected-row overlay style. |
| `overlayColor` | both | overlay-specific | Selected-row overlay color. |
| `fadeEdges` | both | `true` on curve, `false` on flat | Top and bottom fade mask. |
| `overAndUnderCenterOpacity` | both | themed default | Off-center item opacity. |
| `backgroundColor` | flat only | required | Background fill for the flat wheel. |
| `diameterRatio` | curve only | package default | Controls curve depth. Must be positive. |

### Flat vs curve

| Theme | Best for | Default look |
| :---- | :------- | :----------- |
| `FlatDatePickerTheme` | Android-style or fully flat pickers | No edge fade and no off-center dimming |
| `CurveDatePickerTheme` | iOS-like wheel perspective | Curved wheel with edge fade enabled |

### Notes and limitations

- `startDate` must be before `lastDate`, and `initialDate` must stay within the allowed range.
- `locale` defaults to English. If you pass another locale, call `initializeDateFormatting()` from `package:intl/date_symbol_data_local.dart` before building the picker.
- `MonthFormat.twoLetters` with localized month names can collide in some languages. Use `MonthFormat.threeLetters` if you need unique labels.
- Days automatically adjust when the selected month or year changes, including leap years.
- When `listenAfterAnimation` is `false`, `onSelectedItemChanged` fires while the wheel is still moving.

## Example app

There is a runnable example app in [example/lib/main.dart](example/lib/main.dart) plus focused sample widgets in [example/lib/src/widgets/](example/lib/src/widgets/).

## Development

This project uses [FVM](https://fvm.app/) to ensure all contributors use the same Flutter version. Install FVM, then run:

```bash
fvm install
fvm flutter pub get
```

Run tests and lints before committing:

```bash
fvm flutter analyze
fvm flutter test
```

## Contributing

Pull requests are welcome. If you change behavior or public API, keep the README and example app in sync.

Before opening a PR, run:

```bash
fvm flutter analyze
fvm flutter test
```

## Issues

Bug reports and feature requests are best opened in the [GitHub issue tracker](https://github.com/karloows/scroll-wheel-date-picker/issues).

## License

This project is licensed under the [MIT License](LICENSE).

## Contributors

<a href="https://github.com/karloows/scroll-wheel-date-picker/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=karloows/scroll-wheel-date-picker" />
</a>
