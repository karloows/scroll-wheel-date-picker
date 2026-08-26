# Agent Instructions

`scroll_wheel_date_picker` — a Flutter package (wheel-style date picker, curve and flat variants). Published on **pub.dev**, source hosted on a **public** GitHub repo.

Commands and architecture live in [CLAUDE.md](CLAUDE.md) — read that first.

Policies (read all, they're short): [.agents/policies/publishing.md](.agents/policies/publishing.md), [.agents/policies/public-repo.md](.agents/policies/public-repo.md), [.agents/policies/commit-policy.md](.agents/policies/commit-policy.md), [.agents/policies/branch-policy.md](.agents/policies/branch-policy.md), [.agents/policies/pr-policy.md](.agents/policies/pr-policy.md), [.agents/policies/dependency-policy.md](.agents/policies/dependency-policy.md)

## Public repo / published package — read before editing

- This repo is public. Never commit secrets, tokens, or personal data. Assume every commit and PR is visible to anyone.
- The package is already published (current version in `pubspec.yaml`). It's a dependency other people's `pubspec.lock` already resolved against:
  - Any public API change (signature, default value, removed export) is a breaking change — bump `version` in `pubspec.yaml` per semver and add an entry to `CHANGELOG.md` in the same change.
  - Don't rename or remove public symbols in `lib/scroll_wheel_date_picker.dart` or `lib/src/**` casually; check `README.md` for documented usage first.
  - `example/` is `publish_to: none` and depends on the package via `path: ../` — keep it in sync with any API change so it still builds.

## Git conventions

- Don't commit or push directly to `main` unless explicitly asked — see [.agents/policies/branch-policy.md](.agents/policies/branch-policy.md) for branch naming.
- Commit messages follow [.agents/policies/commit-policy.md](.agents/policies/commit-policy.md) — conventional commits with a required body.

## Conventions

- Lints: `flutter_lints` via `analysis_options.yaml` — keep it passing, don't add ignores without reason.
- Follow existing patterns in `lib/src/widgets/` and `lib/src/themes/` rather than introducing new structure for a single widget/theme.
- Update `README.md` when adding/changing a public-facing feature — it's the primary usage doc pub.dev shows.
