# Contributing

Thanks for considering a contribution to `scroll_wheel_date_picker` — a published Flutter package on pub.dev.

## Before you start

Read [AGENTS.md](AGENTS.md) and [CLAUDE.md](CLAUDE.md). They cover architecture, git conventions, API/semver rules, and policies that apply to all contributors, not just AI agents.

## Setup

```sh
flutter pub get
cd example && flutter pub get
```

## Before opening a PR

These must all pass — there is no CI enforcing them, so run manually:

```sh
flutter analyze    # must pass completely
flutter test       # all tests must pass
dart format .      # must be formatted
```

A PR failing any of these won't be merged.

## Understanding the codebase

- `ScrollWheelDatePicker` owns one `DateController` for its lifetime; most changes touch both `lib/src/widgets/scroll_wheel_date_picker.dart` and `lib/src/date_controller.dart`.
- Variants (`CurveScrollWheel` vs `FlatScrollWheel`) are dispatched by the `theme` parameter's runtime type, not an enum. Adding a third variant means adding a third theme subclass and another branch in `_scrollWidget()`.
- Three scroll wheels (day/month/year) are independent; changes in one recompute ranges in others (e.g., selecting February 29 in a leap year). Understand how `DateController` propagates these changes via `ListenableBuilder`.
- `FlatScrollWheel` does not use Flutter's `ListWheelScrollView` — it's built on `FlatWheelScrollView` in `lib/src/widgets/flat_wheel_scroll_view.dart`, a custom scroll view with real behavioral differences from the curve variant. Bug fixes that touch only one variant may miss the other.

See [CLAUDE.md](CLAUDE.md#architecture) for full architecture details.

## Public API changes

This package is live on pub.dev; changes to exports in `lib/scroll_wheel_date_picker.dart` are **public API changes**:

- **Breaking (major):** Removed/renamed exports, required signature changes, changed defaults that break callers. Requires major semver bump.
- **Backward-compatible (minor):** New exports, optional parameters, new helper functions. Requires minor semver bump.
- **Non-API (patch/none):** Internal refactors, tests, docs, CI config, lints. No version bump needed.

For any public API change:
1. Bump `version` in `pubspec.yaml` (`x.y.z+build` format).
2. Add an entry at the top of `CHANGELOG.md` (see existing entries for format).
3. Update `example/` if the API changed so it still builds.
4. Mention the semver bump and CHANGELOG entry in the commit body.

See [.agents/policies/publishing.md](.agents/policies/publishing.md) for details.

## Code style and patterns

- Follow existing patterns in `lib/src/widgets/` and `lib/src/themes/` rather than introducing new structure for a single widget/theme.
- Lints: `flutter_lints` via `analysis_options.yaml` — keep it passing, don't add ignores without reason.

## Git and pull request conventions

**Branch naming:** `<type>/<short-kebab-description>` — e.g., `feat/year-format`, `fix/loop-offset`.  
Allowed types: `feat`, `fix`, `refactor`, `perf`, `docs`, `test`, `chore`, `build`, `ci`.

**Commits:** Conventional commits with a required body.  
Format: `<type>(<scope>): <summary>` (e.g., `fix(controller): handle leap year day count`).  
Scope = narrowest area touched (`widgets`, `themes`, `controller`, `example`, `docs`, `deps`).  
Body = 1–2 lines on *why*, not a restatement of the diff. For public API changes, mention semver and CHANGELOG.

**PRs:**  
- Title: same format as commits (`<type>(<scope>): <summary>`).
- Description: what changed and why. Include a "Breaking change?" line if applicable.
- Base: `development` (don't push to `main` unless explicitly asked).

See [.agents/policies/branch-policy.md](.agents/policies/branch-policy.md), [.agents/policies/commit-policy.md](.agents/policies/commit-policy.md), and [.agents/policies/pr-policy.md](.agents/policies/pr-policy.md) for full details.

## Reporting bugs / requesting features

Use GitHub issue templates:
- [Bug reports](.github/ISSUE_TEMPLATE/bug_report.md) — include steps to reproduce and your environment (version, platform, Flutter version).
- [Feature requests](.github/ISSUE_TEMPLATE/feature_request.md) — describe the problem, proposed behavior, and alternatives.
