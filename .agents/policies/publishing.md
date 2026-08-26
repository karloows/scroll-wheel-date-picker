# Publishing policy

This package is live on pub.dev. Before any change that touches `lib/`:

1. Decide semver impact: patch (bugfix, no API change), minor (new backward-compatible API), major (breaking change) — `pubspec.yaml` uses `x.y.z+build`.
2. Bump `version` in `pubspec.yaml` and add a matching entry at the top of `CHANGELOG.md` (see existing entries for format — short bullet list).
3. Don't bump the version or touch `CHANGELOG.md` for internal-only changes (tests, example app, docs, CI config) unless asked.
4. Never run `dart pub publish` / `flutter pub publish` — that's a one-way action only the maintainer takes.
