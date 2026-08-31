---
name: dependency-management
description: Use when adding, removing, or updating package dependencies in this published Flutter package. Keep consumer-facing dependencies minimal, prefer Dart or Flutter built-ins, and avoid incidental version churn.
---

# Dependency Management

Use this skill when work touches `pubspec.yaml`, lockfiles, or package version
choices.

## Rules

- Prefer Flutter or Dart built-ins first.
- Add a runtime dependency only when the package clearly needs it.
- Remember that `dependencies:` become transitive dependencies for package
  consumers.
- Keep unrelated version bumps out of the same diff.

## Hygiene

- Touch `pubspec.lock` only when the work requires it.
- Keep `example/` building against the local package after dependency changes.
- If a dependency change also changes the public package behavior, update
  `CHANGELOG.md` and the package version when required.

## Read These

- `.claude/policies/dependency-policy.md`
- `.claude/policies/publishing.md`
- `.claude/policies/public-repo.md`
