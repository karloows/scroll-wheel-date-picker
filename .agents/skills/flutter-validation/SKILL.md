---
name: flutter-validation
description: Use when validating code changes in this package. Run the smallest honest checks while iterating, then finish with flutter analyze and flutter test before handoff.
---

# Flutter Validation

Use this skill when app, package, example, or test code changed.

## Validation Flow

1. Use the smallest check that proves the edited area while iterating.
2. Finish with `flutter analyze`.
3. Finish with `flutter test`.
4. If public API or documented behavior changed, review `README.md`,
   `CHANGELOG.md`, and `example/` for consistency.
5. Report exactly what ran and what did not.

## Notes

- This repo does not rely on CI to catch missed local validation.
- If a change touches only docs or repo workflow files, document review may be
  enough.

## Read These

- `CLAUDE.md`
- `.agents/policies/publishing.md`
- `.agents/policies/public-repo.md`
