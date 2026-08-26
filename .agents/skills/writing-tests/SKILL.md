---
name: writing-tests
description: Use when adding or updating tests for this package. Prefer behavior-level coverage for date selection, limits, and wheel behavior, and keep tests aligned with the published API.
---

# Writing Tests

Use this skill when the task is to add, update, or repair tests.

## Test Rules

- Prefer behavior-level tests over private implementation checks.
- Cover the real risk: selected date, valid ranges, callbacks, and visible
  wheel behavior.
- When a shared path is changed, consider whether both curve and flat wheels
  need coverage.
- Keep tests close to the package behavior they protect.
- Avoid test-only seams that worsen the public package design.

## Validation Flow

1. Run focused `flutter test` commands while iterating when useful.
2. Finish with `flutter analyze`.
3. Finish with `flutter test`.

## Read These

- `CLAUDE.md`
- `.agents/policies/publishing.md`
- `.agents/policies/public-repo.md`
