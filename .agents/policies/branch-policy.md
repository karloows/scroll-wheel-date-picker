# Branch policy

- Don't commit directly on `main` unless the user explicitly asks for that exception.
- Branch names: `<type>/<short-kebab-description>`, e.g. `fix/loop-offset`, `feat/year-format`.
- Allowed types: `feat`, `fix`, `refactor`, `perf`, `docs`, `test`, `chore`, `build`, `ci`.
- Keep the description to 2-3 words max, generated from the actual diff, not assumptions.
- Use the slash form exactly as written above. Do not flatten it to names like `docs-readme-name` just to work around a local ref issue; resolve the ref issue or ask the user before deviating.
- When the user says `ship`, create and check out a new branch that follows this naming policy before committing.
- After a PR is merged: switch the local checkout back to `main`, pull the merged changes, and delete the local feature branch.
