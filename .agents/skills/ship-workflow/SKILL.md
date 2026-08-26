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
- Keep the existing PR title when it still explains the whole branch. Update it
  only when the branch scope changed enough that the current title no longer
  fits.
- Keep the PR description short and public-safe.
- Call out breaking changes explicitly.

## Trigger words

When the user says **"ship"**, run without asking for confirmation:
1. `git checkout -b <type>/<short-kebab-description>` off the current base branch.
2. Commit staged/relevant changes per the Commits section above.
3. Push the branch.
4. Open a PR via the `github-personal` MCP server (not `gh`) per the Pull Requests section above.

When the user says **"land"**, run without asking for confirmation:
1. Squash-and-merge the open PR via the `github-personal` MCP server.
2. Check out the base branch the PR merged into.
3. `git pull` to bring the merge down locally.
4. Delete the feature branch, both local and remote.

## Read These

- `.agents/policies/branch-policy.md`
- `.agents/policies/commit-policy.md`
- `.agents/policies/pr-policy.md`
- `.agents/policies/public-repo.md`
- `.agents/policies/publishing.md`
