# Claude Folder Guide

This folder keeps repo-local guidance for Claude-style agents working on
`scroll_wheel_date_picker`.

## Purpose

- Keep package workflow rules versioned with the code.
- Make public-repo and published-package constraints easy to find.
- Add reusable skills for common package tasks.

## Structure

- `.claude/policies/`
  - Short rules for publishing, public-repo hygiene, branches, commits, PRs,
    and dependencies.
- `.claude/skills/`
  - Repo-local skills for package work such as bug fixing, validation,
    reviews, testing, and ship workflow.

## Standard Workflow

1. Read `CLAUDE.md`, `AGENTS.md`, and the relevant policy files.
2. Check the current branch and working tree state.
3. Trace the affected public API, controller, widget, and wheel variant before
   editing.
4. Keep the diff scoped to the requested change.
5. Run `flutter analyze` and `flutter test` before handoff when Dart or
   Markdown files changed.
6. If `lib/` changed in a public-facing way, decide semver impact and note it
   in the commit or PR body, but leave `pubspec.yaml` and `CHANGELOG.md`
   unchanged until the publishing flow.
7. Keep `README.md` and `example/` aligned with any public API or behavior
   change.

## Public Package Notes

- This repository is public. Treat every commit, PR, comment, and example as
  externally visible.
- Avoid casual public API changes in `lib/scroll_wheel_date_picker.dart` and
  `lib/src/**`.
- Never publish from an agent session.
