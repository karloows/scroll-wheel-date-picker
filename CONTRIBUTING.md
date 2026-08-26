# Contributing

Thanks for considering a contribution to `scroll_wheel_date_picker`.

## Setup

```sh
flutter pub get
cd example && flutter pub get
```

## Before opening a PR

```sh
flutter analyze
flutter test
dart format .
```

There is no CI enforcing analyze/test, so run these yourself — a PR that fails either won't be merged.

## Guidelines

- Read [AGENTS.md](AGENTS.md) and [CLAUDE.md](CLAUDE.md) first — they cover architecture, git/branch/commit conventions, and public API/publishing rules that apply to human contributors too.
- This package is published on pub.dev; changes to `lib/scroll_wheel_date_picker.dart` or its exports are public API changes and need a CHANGELOG entry and correct semver bump (see [.agents/policies/publishing.md](.agents/policies/publishing.md)).
- Keep `example/` in sync with any API change.
- Follow existing patterns in `lib/src/widgets/` and `lib/src/themes/` rather than introducing new structure for a single widget/theme.

## Pull requests

- Branch and commit conventions: [.agents/policies/branch-policy.md](.agents/policies/branch-policy.md), [.agents/policies/commit-policy.md](.agents/policies/commit-policy.md).
- PR conventions: [.agents/policies/pr-policy.md](.agents/policies/pr-policy.md).

## Reporting bugs / requesting features

Open a GitHub issue with a clear description and, for bugs, steps to reproduce.
