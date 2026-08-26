@AGENTS.md

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Process/policy conventions (git, publishing, PRs, dependencies) live in [AGENTS.md](AGENTS.md) — read that too.

## Commands

```sh
flutter pub get              # install deps (run in repo root and example/)
flutter analyze              # lint, must pass
flutter test                 # run all widget tests
flutter test test/wheel_date_picker_test.dart   # run the single test file
dart format .                # format
```

There is no CI enforcing analyze/test — run both yourself before considering a change done.

## Architecture

`ScrollWheelDatePicker` (`lib/src/widgets/scroll_wheel_date_picker.dart`) is a `StatefulWidget` that owns one `DateController` (`lib/src/date_controller.dart`) for its lifetime. Understanding a change usually means tracing across both files plus whichever scroll-wheel variant is in play:

- **`DateController`** is a `ChangeNotifier` that internally owns three private sub-controllers — `_DayController`, `_MonthController`, `_YearController` (all defined in `date_controller.dart`, not exported). It derives valid day/month/year ranges from `initialDate`/`startDate`/`lastDate` via constructor `assert`s, and recomputes the day count when month/year changes (leap years etc.). `ScrollWheelDatePicker` never touches dates directly — it calls `_dateController.changeDay/changeMonth/changeYear` and reads `_dateController.dateTime` back out.
- **Variant dispatch**: `ScrollWheelDatePicker._scrollWidget()` picks `CurveScrollWheel` vs `FlatScrollWheel` based on `runtimeType` of `widget.theme` (`CurveDatePickerTheme` vs `FlatDatePickerTheme`), not an enum — adding a third variant means adding a third theme subclass and another branch here, not extending an enum.
- **Three independent scroll wheels** (days/months/years) are laid out in a `Row`, each wrapped in its own `ListenableBuilder` listening to the shared `_dateController` — a change in one wheel (e.g. changing month affects day count) re-renders the others without them owning that state themselves.
- **`CurveScrollWheel`** wraps Flutter's `ListWheelScrollView` directly for the perspective effect. **`FlatScrollWheel`** does not use `ListWheelScrollView` — it's built on top of `FlatWheelScrollView` (`lib/src/widgets/flat_wheel_scroll_view.dart`, the largest file in `widgets/`), a custom scroll view that reimplements the same centered-selection/looping behavior without curve perspective. These two are not thin variants of each other; expect real behavioral differences when fixing bugs reported against only one of them.
- **Overlays** (`lib/src/widgets/overlays/`: `holo`, `highlight`, `line`) are simple positioned decorations selected by `widget.theme.overlay` in `ScrollWheelDatePicker._overlay()` — they don't touch scroll or date logic.
- **Themes** (`lib/src/themes/`): `ScrollWheelDatePickerTheme` is the abstract base; `CurveDatePickerTheme`/`FlatDatePickerTheme` add variant-specific fields (e.g. `diameterRatio` only exists on the curve theme). The theme object is both a styling config and the type-switch discriminator described above.
- **Public surface** is exactly what `lib/scroll_wheel_date_picker.dart` exports: the picker widget, the theme base + constants, and `DateController`. Everything else under `lib/src/` is implementation detail.
