# Publishing policy

This package is live on pub.dev.

- **Never bump `version` in `pubspec.yaml` or add a `CHANGELOG.md` entry as part of a regular fix/feat/chore commit or PR** — even when the change affects the public API or user-visible behavior. Versioning happens exactly once, at release time, via the `publish` skill (`.claude/skills/publish/SKILL.md`), which diffs everything since the last version-bump commit and bumps/changelogs the accumulated changes together. A normal PR just fixes the bug or ships the feature; landing many small "patch bump" commits produces version churn and CHANGELOG entries that don't correspond to actual pub.dev releases.
- When you land a change with public-API or user-visible impact, note the semver impact (patch/minor/major) and why in the PR/commit body instead, so it's easy to fold in at release time — see [commit-policy.md](commit-policy.md).
- Never run `dart pub publish` / `flutter pub publish` — that's a one-way action only the maintainer takes.
- Only touch `version`/`CHANGELOG.md` when explicitly running the `publish` skill/flow.
