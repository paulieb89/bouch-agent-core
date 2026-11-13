---
name: handoff-authoring
description: Create, review, update, or compact durable agent handoffs, session-transfer notes, kickoffs, and bounded task packets. Use whenever work will continue in a fresh agent session, moves between agents or providers, or carries decisions or evidence across sessions; whenever a paid, live, or publishing action has just run, a decision has changed, or a reviewable artifact has been produced; before ending a session that leaves uncommitted work; when a handoff has grown into a dated journal; or when work needs explicit production, live-system, paid-system, or do-not-touch boundaries.
---

# Handoff authoring

Keep the smallest durable project artifact that lets a fresh agent continue
the work without access to the originating conversation. A handoff is a
project document, not a transcript, memory database, orchestration layer, or
claim that work was completed.

The default handoff is a **current-state document**: one per project,
rewritten in place so it always describes now. History is kept by source
control, not by appending dated sections. A handoff that has to be read
from the bottom up to find the present has stopped working.

## Before writing

1. Inspect the project's contract, README, current-state or memory files, and
   existing handoff conventions. Prefer the project's established location and
   naming convention.
2. Identify the authoritative sources for the task. Point at those files,
   commits, runtime artifacts, tests, or qualified evidence rather than
   copying their contents into the handoff.
3. Separate verified facts, settled decisions, inferences, proposals, open
   questions, and approvals. Do not turn an inference into a decision.
4. Select one shape from the bundled template using the stakes and risk
   profile, not habit.

If the project has no handoff convention, use `HANDOFF.md` at the repository
root for the current-state document. Use a project-specific plan or task
directory only when the project contract already establishes one.

## Choose the shape

- **Shape A — current-state handoff:** the project's standing continuity
  document. Rewritten in place; bounded in length. A long-running,
  separately-scoped thread (an investigation, an amendment) may get its own
  Shape A file with a `status`, linked from the project's handoff.
- **Shape B — lightweight kickoff:** a small, fully diagnosed, low-blast-radius
  change with a short verification path.
- **Shape C — bounded task packet:** live, paid, production, or hard-boundary
  work that needs scope and permission gates before an agent starts. Shape C is
  an authorisation boundary, not a retrospective continuity report.

Read `references/TEMPLATE-handoff.md` for the selected shape. Do not fill a
Shape C packet by inheriting commands, paths, environments, or sources from a
different repository; confirm each one exists in the target project.

## When to update

Update the current-state handoff when one of these events happens, at the
time it happens — not only when a session is believed to be ending:

1. A paid, live, publishing, or otherwise consequential action has run.
2. A decision in force has changed or been superseded.
3. An artifact the user is expected to review has been produced.
4. A session is about to end with uncommitted or untracked work.

Do not update on every commit or every step. Routine progress that source
control already records needs no handoff entry.

## Authoring rules

- Make the document self-contained for a fresh local or hosted agent session.
- Rewrite sections to describe the present. When a decision changes, replace
  it and leave one line: `superseded <date>: <old> → <new> (<reason>)`. Do not
  append a new dated section to carry the change.
- Stay within the template's length budget. When the handoff exceeds it,
  compact it (below) rather than letting it grow.
- Record `as_of` (date and commit) and list every in-flight path —
  uncommitted, untracked, or awaiting review — with what it is. Anything in
  the working tree that the handoff does not list is, by definition, not
  handed off.
- Record what was observed and how it was observed. A source link alone does
  not prove that the current runtime or artifact was checked.
- Record every consequential action in the handoff's approvals-and-spend
  section: date, action, the approval it relied on and where that approval
  was given, cost, and evidence path. If no approval can be located, write
  `approval not recorded` — never omit the line or infer an approval.
- Put approval gates before the action they govern. Do not treat a handoff as
  retroactive authorisation to deploy, publish, send, delete, spend, or modify
  a live system. A standing authorisation (for example a per-unit budget for
  a recurring release) is recorded with its scope, limit, grantor, date, and
  expiry, and each action cites it.
- Link to canonical documents instead of restating them. Keep the handoff
  concise enough to be read at the start of a new session.
- Close the loop explicitly when the work is done. Do not delete the handoff
  merely because it is complete.

## Contract and handoff boundary

The project contract (`CLAUDE.md`, `AGENTS.md`, or equivalent) holds stable
rules and boundaries; the handoff holds current state. Do not copy current
direction, balances, figures, or dated status into the contract — they drift
from the handoff and from the source. The contract needs one line pointing at
the handoff. When you find current state in the contract, move it.

## Recurring production

When a project produces repeated units (episodes, releases, reports, batches),
each unit's state lives with the unit — a manifest or README in the unit's
own directory recording its stage, sources, settings, costs, review outcome,
and release status. The project handoff then indexes units by stage and
carries only cross-cutting state: the cadence, standing authorisations and
budget consumed against them, blockers, and the next unit's first action.
Do not narrate each unit's production in the project handoff.

## Reading a handoff

Treat a handoff as a dated claim, not current truth. Before relying on it,
compare it with the repository: commits after its `as_of` commit, and
working-tree paths it does not list as in flight, mean it is stale. Report
the drift and update the handoff before building on it. A project's own
`/prime` is the natural place for this check (see `prime-authoring`).

## Compacting a journal-style handoff

When an existing handoff has grown by appending dated sections:

1. Preserve the old text once, unedited: either rely on its source-control
   history and say so, or move it to a dated archive file named in the new
   handoff. Do not edit the archive afterwards.
2. Write a fresh Shape A document. Re-verify each fact carried forward
   against the repository or artifact; carry forward unverified items as
   open questions, not facts.
3. Keep decisions still in force; reduce superseded ones to one line each.
4. Route reusable lessons found in the old text to the observation log
   (`observation-log`), not into the new handoff.
5. Move any current state found in the project contract into the handoff.

## Evidence and continuity boundaries

Use repository files, source control, tests, runtime observations, rendered
artifacts, and qualified workbench evidence according to the project's actual
precedence. Historical session inspection can locate prior context when the
task calls for it, but raw transcripts and large logs do not belong in the
working handoff by default.

Do not create or update a shared memory store, Registry record, orchestration
state, or session database as part of authoring a handoff. Those systems have
separate responsibilities. The handoff should reference them only when they
are an authoritative source for this specific task.

## Final review

Before handing the document to the next agent, check:

- A fresh agent can identify the objective and the first safe action.
- It describes the present without reading history; it is within the length
  budget.
- `as_of` is current and every in-flight path in the working tree is listed.
- Every consequential action has a ledger line with an approval reference or
  `approval not recorded`.
- Every source-of-truth path exists or is clearly marked as an external
  dependency.
- Facts, decisions, inferences, proposals, and open questions are distinct.
- Acceptance and evidence requirements are observable.
- Production, live-system, paid-system, publishing, and do-not-touch boundaries
  are explicit where relevant.
- The project contract holds no copied current state.
- No test, commit, deployment, inspection, or approval is claimed without
  evidence.
- The closing instructions tell the next agent what to preserve, verify, and
  report back.
