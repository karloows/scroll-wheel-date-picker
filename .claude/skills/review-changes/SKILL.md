---
name: review-changes
description: Use when reviewing code or docs changes in this package. Prioritize regressions, public API compatibility, semver and changelog gaps, and missing validation before handoff.
---

# Review Changes

Use this skill for self-review, requested review, or pre-handoff checking.

## Review Order

1. Regressions in date selection, limits, scrolling, or theme behavior.
2. Public API changes in `lib/scroll_wheel_date_picker.dart` or exported
   behavior under `lib/src/`.
3. Missing semver or `CHANGELOG.md` updates for public-facing package changes.
4. README or `example/` drift after public API or behavior changes.
5. Validation gaps or unnecessary dependency additions.
6. Public-repo hygiene issues such as secrets or personal data.

## Output Rules

- Findings first.
- Tie each finding to a file or behavior.
- If no findings remain, say so directly and still mention any real validation
  gap.

## Read These

- `.claude/policies/publishing.md`
- `.claude/policies/public-repo.md`
- `.claude/policies/dependency-policy.md`
