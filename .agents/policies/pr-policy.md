# Pull request policy

Public repo — PR title/description are visible to anyone and become part of the permanent history.

- Title: same format as commits, `<type>(<scope>): <summary>` (see [commit-policy.md](commit-policy.md)).
- Description: what changed and why, plus a "Breaking change" line if the public API changed (link the CHANGELOG entry).
- If a credential or secret leaked, revoke or rotate it immediately, then
  purge it from affected refs and clones before opening a PR against `main`.
- Never open a PR against `main` from a branch containing secrets in its
  history.
