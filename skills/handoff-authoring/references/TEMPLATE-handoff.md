# Handoff / kickoff / task-packet template

Three shapes. Pick based on stakes and risk profile, not habit.

## Shape A — full handoff

Use for a real decision, investigation, amendment, or multi-session thread.

```markdown
---
status: active | landed | superseded
repo: <repository name>
date: <YYYY-MM-DD>
supersedes: <prior file, or "none">
sessions: <sessions or agents that contributed>
---

# Handoff: <title>

## Purpose and scope

<The outcome this handoff transfers and what it does not cover.>

## Source of truth

- `<path or URL>` — <what it establishes and why it is authoritative>
- `<path or commit>` — <what was actually observed>

## Verified facts

- <fact> — observed by <test, inspection, runtime check, or artifact>

## Decisions

- <decision> — <reason and date>
- **AMENDED:** <decision changed> — <what changed and why>
- **INVESTIGATED:** <question checked> — <result and evidence>

## Open items

1. <Concrete next question or action, ready for the next session.>
2. <Concrete next question or action.>

## Next-session instructions

<Tell a fresh agent what to read first, what to preserve, what to verify,
and what it must not assume.>

## Evidence and completion report

- Files changed: <paths, or none>
- Tests/probes run: <commands and results, or not run>
- Evidence: <paths or links>
- Blockers: <none or concrete blockers>

Closed <YYYY-MM-DD> — <one-line outcome, when complete>
```

## Shape B — lightweight kickoff

Use for a small, fully diagnosed, low-blast-radius change.

```markdown
---
repo: <repository name>
date: <YYYY-MM-DD>
purpose: <one line>
---

# Kickoff: <task title>

## Known

- <verified fact and source>

## Check before implementation

- <only genuinely unresolved check, or "none">

## Fix

<The bounded change to make.>

## Verification

Run a fresh terminal verification:

- `<command>` — <expected observable result>

## Output

- Files changed: <paths>
- Tests run: <pass/fail/skipped>
- Evidence: <paths>
- Blockers: <none or concrete blockers>
```

## Shape C — bounded task packet

Use before work touching a live, paid, production, publishing, or otherwise
hard-boundary system. This is a scope-and-permission contract, not a continuity
report.

```markdown
---
repo: <repository name>
date: <YYYY-MM-DD>
purpose: <one line>
touches: live | paid | production | hard-boundaries
---

# Task packet: <task title>

## Goal

<One sentence describing the observable outcome.>

## External boundaries

- <system, API, MCP tool, CLI or service> — <what it does in this task>
- none

## Assumptions to validate

- <assumption>
- none

## Files to inspect first

1. `<path>` — <why>
2. `<path>` — <why>

## Source-of-truth documents

- `<path>` — <what it governs>

## Evidence to gather first

- <what to capture and where>
- none

## Live probes before starting

- [ ] `<read-only command>` — <why it is live or paid>
- none

## Out of scope

- Do not modify <system or file>.
- Do not start <action> until <precondition>.

## Allowed commands

- `<command>`

## Do not touch

- <critical file or system>
- none

## Acceptance criteria

- [ ] <specific observable outcome>

## Evidence of completion

- <diff, artifact, command output or test result>

## Mutating actions requiring approval

- [ ] `<command or action>` — <side effect>
- none

## Output format

- Files changed: <paths>
- Tests run: <pass/fail/skipped>
- Evidence: <paths>
- Blockers: <none or concrete blockers>
```

## Rules shared by all shapes

- Point at canonical documents rather than copying them.
- State `none` when a section has no entries; do not silently omit it when the
  distinction matters.
- Tick checkboxes when the condition becomes true, not only at session end.
- Approval gates are written before work starts and are not expanded
  retroactively.
- A verified platform or repository claim belongs in the project's evidence or
  field-notes system when one exists; a small backlog item belongs in the
  project's backlog; this document is for continuity and bounded transfer.

## Routing

- Real decision, investigation, or multi-session thread: Shape A.
- Small diagnosed fix: Shape B.
- Live, paid, production, publishing, or hard boundaries: Shape C.
