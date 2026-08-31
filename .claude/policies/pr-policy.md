# Pull request policy

Public repo — PR title/description are visible to anyone and become part of the permanent history.

- Use the `github-personal` MCP server for GitHub operations (creating/updating PRs, issues, comments) on this repo, not the `gh` CLI — it's tied to the correct account for this repo.
- Title: same format as commits, `<type>(<scope>): <summary>` (see [commit-policy.md](commit-policy.md)).
- Keep the existing PR title when it still accurately describes the full branch diff. Update it only when the scope or summary no longer fits the cumulative changes.
- Description: what changed and why. If the public API changed, include the semver impact and why; a PR or issue link is optional supporting context.
- When the user says `ship`, push the branch and open the PR as part of that workflow. Do not stop after a local commit unless the user asked for commit-only.
- When the user says `land`, squash-merge the PR rather than creating a merge commit or rebase merge, then finish the local cleanup steps from [branch-policy.md](branch-policy.md).
- If a credential or secret leaked, revoke or rotate it immediately, then
  purge it from affected refs and clones before opening a PR against `main`.
- Never open a PR against `main` from a branch containing secrets in its
  history.
