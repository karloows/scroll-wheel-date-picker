# Commit policy

- Format: `<type>(<scope>): <summary>` (conventional commits).
- Scope = the narrowest area the diff actually touches (`widgets`, `themes`, `controller`, `example`, `docs`, `deps`, `dev`) — don't default to something generic when a specific one fits. Use `dev` for developer tooling and contributor infrastructure (FVM config, CI setup, lint rules).
- Every commit needs a body: 1-2 short lines on *why*, not a restatement of the diff.
- If the change affects the public API or user-visible behavior, note the semver impact (patch/minor/major) and why in the body — but don't bump `version` or touch `CHANGELOG.md` yourself; that happens only at release time (see [publishing.md](publishing.md)).
