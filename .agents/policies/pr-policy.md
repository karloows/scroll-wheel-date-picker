# Pull request policy

Public repo — PR title/description are visible to anyone and become part of the permanent history.

- Use the `github-personal` MCP server for GitHub operations (creating/updating PRs, issues, comments) on this repo, not the `gh` CLI — it's tied to the correct account for this repo.
- Title: same format as commits, `<type>(<scope>): <summary>` (see [commit-policy.md](commit-policy.md)).
- Keep the existing PR title when it still accurately describes the full branch diff. Update it only when the scope or summary no longer fits the cumulative changes.
- Description: what changed and why, plus a "Breaking change" line if the public API changed (link the CHANGELOG entry).
- If a credential or secret leaked, revoke or rotate it immediately, then
  purge it from affected refs and clones before opening a PR against `main`.
- Never open a PR against `main` from a branch containing secrets in its
  history.
