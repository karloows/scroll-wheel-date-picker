---
name: publish
description: Prepare scroll_wheel_date_picker for a pub.dev release - bump version, update CHANGELOG, verify example/lints/tests. Use when the user says "publish", "release", "bump version", or "prep for pub.dev".
---

# Publish checklist

Follow `.claude/policies/publishing.md` for the semver/CHANGELOG rules. Steps:

1. Find the latest commit that changed the `version:` line in `pubspec.yaml` (for example with `git log -G '^version:' --format=%H -- pubspec.yaml`) and diff `lib/` from that version-bump commit to decide semver impact: patch/minor/major.
2. Bump `version` in `pubspec.yaml` (`x.y.z+build`).
3. Add a new entry at the top of `CHANGELOG.md` — short bullet list, matching the style of existing entries.
4. Run `flutter analyze` and `flutter test` — both must pass.
5. Run `flutter pub get` in `example/` and `flutter analyze` there too, to confirm the example app still compiles against the change.
6. If a public-facing feature changed, update `README.md` (and regenerate a `demo/` GIF if visible behavior changed).
7. Stop — do not run `flutter pub publish` or `dart pub publish`. Report the diff and let the user publish themselves.
