## Summary

**What changed:** Concise 1-2 line description of the changes.

**Why:** Explain the motivation or problem being solved.

## Breaking change?

- [ ] **Yes** — public API change (see note below)
- [ ] **No**

### If yes, breaking change:
- [ ] Version bumped in `pubspec.yaml` (major version)
- [ ] Entry added to `CHANGELOG.md` (top of file)
- [ ] `example/` updated to work with the new API
- [ ] Commit body mentions semver bump and CHANGELOG entry (see [.agents/policies/publishing.md](../.agents/policies/publishing.md))

## Non-breaking API changes?

If this adds new public exports or optional parameters:
- [ ] Version bumped in `pubspec.yaml` (minor version)
- [ ] Entry added to `CHANGELOG.md`
- [ ] `example/` still builds
- [ ] Commit body mentions semver bump and CHANGELOG entry

If this is internal-only (tests, docs, internal refactors, CI):
- [ ] No version bump needed
- [ ] No CHANGELOG entry needed

## Pre-submission checklist

- [ ] `flutter analyze` passes completely
- [ ] `flutter test` passes completely
- [ ] `dart format .` run (all code formatted)
- [ ] Commits follow [conventional commit format](../.agents/policies/commit-policy.md) (`type(scope): summary`)
- [ ] Commit bodies explain the *why*, not just the *what*
- [ ] `example/` builds and works (if API changed)
- [ ] No unrelated changes mixed in (one PR = one logical change)

## Related issues

Closes #[issue number] (if applicable)
