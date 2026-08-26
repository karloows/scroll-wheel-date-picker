# Dependency policy

This package's `dependencies:` become every consumer's transitive dependencies — keep the list minimal.

- Don't add a new `dependencies:` entry for something solvable with Flutter/Dart stdlib or a few lines of code.
- `dev_dependencies:` (lints, testing) are freer, but still justify additions.
- Dependabot PRs (`.github/dependabot.yml`): check the changelog for major bumps before merging; patch/minor `dev_dependencies` bumps are safe to merge on green CI.
- Never pin to a specific patched fork or git URL in a published package — pub.dev rejects/flags it.
