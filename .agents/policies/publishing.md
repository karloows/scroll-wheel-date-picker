# Publishing policy

This package is live on pub.dev. When a change under `lib/` affects the public
API or user-visible package behavior:

1. Decide semver impact: patch (bugfix, no breaking API change), minor (new backward-compatible API or behavior), major (breaking API or behavior change) — `pubspec.yaml` uses `x.y.z+build`.
2. Bump `version` in `pubspec.yaml` and add a matching entry at the top of `CHANGELOG.md` (see existing entries for format — short bullet list).
3. Do not bump the version or touch `CHANGELOG.md` for internal-only changes that do not alter the public API or user-visible package behavior, such as tests, docs, CI config, or internal refactors, unless asked.
4. Never run `dart pub publish` / `flutter pub publish` — that's a one-way action only the maintainer takes.
