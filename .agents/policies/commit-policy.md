# Commit policy

- Format: `<type>(<scope>): <summary>` (conventional commits).
- Scope = the narrowest area the diff actually touches (`widgets`, `themes`, `controller`, `example`, `docs`, `deps`, `dev`) — don't default to something generic when a specific one fits. Use `dev` for developer tooling and contributor infrastructure (FVM config, CI setup, lint rules).
- Every commit needs a body: 1-2 short lines on *why*, not a restatement of the diff.
- If the change affects the public API, mention the semver bump and CHANGELOG entry in the body (see [publishing.md](publishing.md)).
