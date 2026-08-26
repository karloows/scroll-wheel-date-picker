---
name: task-planning
description: Use when package work has multiple moving parts and benefits from a short plan. Inspect the real widget, controller, theme, and publishing surface first, then keep the plan concrete and small.
---

# Task Planning

Use this skill for non-trivial package work that benefits from a short
execution plan.

## Planning Rules

1. Read `CLAUDE.md`, `AGENTS.md`, and the relevant policies before planning.
2. Plan around the real package flow: public export, `DateController`,
   `ScrollWheelDatePicker`, and the affected wheel variant.
3. Keep the plan to a few concrete steps tied to files or behaviors.
4. Include validation when code behavior changes.
5. Include semver, changelog, README, or example updates only when the change
   actually affects the public package surface.

## Good Plan Shape

- inspect the current flow
- edit the smallest responsible files
- add or adjust focused tests if needed
- run analyze and test
- review public-package follow-through before handoff
