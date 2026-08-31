---
name: bug-fixing
description: Use when fixing a bug, regression, or incorrect behavior in this Flutter package. Trace DateController, the picker widget, and the active wheel variant before editing, then keep the fix small and validate with analyze plus tests.
---

# Bug Fixing

Use this skill for broken picker behavior, controller regressions, wrong date
limits, wheel-selection issues, or theme-specific rendering bugs.

## Workflow

1. Read `CLAUDE.md`, `AGENTS.md`, and the relevant policy files first.
2. Trace the flow through `lib/src/date_controller.dart`,
   `lib/src/widgets/scroll_wheel_date_picker.dart`, and the affected curve or
   flat wheel implementation before choosing an edit point.
3. Check whether the bug is shared across both wheel variants or isolated to
   one.
4. Fix the narrowest shared root cause that matches the report.
5. Add or update tests when the change touches non-trivial behavior.
6. Run `flutter analyze` and `flutter test` before handoff.

## Bias

- Prefer one fix in shared controller or widget logic over patching both wheel
  variants separately.
- Preserve the published public API unless the task explicitly requires a
  breaking change.
- If a public-facing behavior change lands in `lib/`, decide semver impact and
  update `CHANGELOG.md` in the same change.

## Read These

- `CLAUDE.md`
- `.claude/policies/publishing.md`
- `.claude/policies/public-repo.md`
- `.claude/policies/dependency-policy.md`
