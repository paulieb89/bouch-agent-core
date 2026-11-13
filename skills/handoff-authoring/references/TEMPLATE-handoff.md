# Handoff / kickoff / task-packet template

Three shapes. Pick based on stakes and risk profile, not habit.

## Shape A — current-state handoff

The project's standing continuity document. Rewrite sections in place so the
document always describes the present; source control keeps the history.
Length budget: about 100 lines. Past that, compact it (see the Skill) rather
than append.

A separately-scoped long-running thread may use this shape in its own file,
with `status: active | landed | superseded` added to the frontmatter and a
link from the project handoff.

```markdown
---
repo: <repository name>
as_of: <YYYY-MM-DD> <sha of the commit this content was checked against —
      freshness is judged against later commits EXCLUDING handoff-file
      changes, e.g. `git log <as_of>..HEAD -- . ':!HANDOFF.md'`>
archive: <path to frozen prior handoff text, or "git history">
sessions: <recent native session ids worth resuming, or none>
---

# Handoff: <project>

## Now

<Two or three sentences: the objective, where it stands, and the single
next safe action.>

## Verified state

- <fact> — observed by <test, inspection, runtime check, or artifact>

## In flight

Known uncommitted, untracked, or awaiting-review paths — `git status` is
the check; this list is the writer's claim, not a registry.

- `<path>` — <what it is; who must review or decide what>
- none

## Decisions in force

- <decision> — <reason, date>
- superseded <date>: <old> → <new> (<reason>)

## Approvals and spend

Standing authorisations:

- <scope> — limit <amount or count>, granted by <who> on <date> via
  <where recorded>, expires <date or condition>; consumed <derived from
  the open-period ledger rows>

Consequential actions (paid, live, publishing, destructive). Keep the
current period's rows only — roll closed rows into the unit manifest or
the dated archive; derive totals, don't re-state them:

| Date | Action | Approval relied on | Cost | Evidence |
|------|--------|--------------------|------|----------|
| <date> | <action> | <reference, or `approval not recorded`> | <amount> | `<path>` |

## Open questions

1. <question, and who answers it>

## Boundaries

- <do-not-touch, live, paid, or publishing gates that apply right now>

## Next-session instructions

<What to read first, what to preserve, what to verify before relying on
this document, and what must not be assumed.>
```

For recurring production, add a units index and keep each unit's detail in
the unit's own manifest:

```markdown
## Units

| Unit | Stage | Manifest | Blocker |
|------|-------|----------|---------|
| <id> | brief / script / production / review / approved / released | `<path>` | <none or blocker> |
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
  retroactively. A consequential action with no locatable approval is
  recorded as `approval not recorded`, never omitted.
- Current state lives in the handoff, not in the project contract.
- A verified platform or repository claim belongs in the project's evidence or
  field-notes system when one exists; a small backlog item belongs in the
  project's backlog; this document is for continuity and bounded transfer.

## Routing

- Project continuity, or a separately-scoped multi-session thread: Shape A.
- Small diagnosed fix: Shape B.
- Live, paid, production, publishing, or hard boundaries: Shape C.
