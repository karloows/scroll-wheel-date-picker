---
name: ship-workflow
description: Use when branch, commit, push, or pull request workflow is part of the task. Follow this public package repo's branch, commit, PR, and publishing constraints without pushing directly to main.
---

# Ship Workflow

Use this skill when the task includes creating a branch, committing, pushing,
or opening a PR.

## Branches

- Use `<type>/<short-kebab-description>`.
- Keep the description to two or three words.
- Base the name on the actual diff, not the ticket title.
- Do not commit or push directly to `main` unless the user explicitly asks.

## Commits

- Use `<type>(<scope>): <summary>`.
- Use the narrowest real scope such as `widgets`, `themes`, `controller`,
  `example`, `docs`, or `deps`.
- Include a short body explaining why.
- Mention semver and `CHANGELOG.md` when the public API changed.

## Pull Requests

- Use the same title format as commits.
- Keep the PR description short and public-safe.
- Call out breaking changes explicitly.

## Read These

- `.agents/policies/branch-policy.md`
- `.agents/policies/commit-policy.md`
- `.agents/policies/pr-policy.md`
- `.agents/policies/public-repo.md`
- `.agents/policies/publishing.md`
