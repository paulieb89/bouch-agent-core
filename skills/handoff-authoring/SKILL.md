---
name: handoff-authoring
description: Create, review, or update durable agent handoffs, session-transfer notes, kickoffs, and bounded task packets. Use whenever work will continue in a fresh agent session, move between agents or providers, carries decisions or evidence across sessions, or needs explicit production, live-system, paid-system, or do-not-touch boundaries.
---

# Handoff authoring

Create the smallest durable project artifact that lets a fresh agent continue
the work without access to the originating conversation. A handoff is a
project document, not a transcript, memory database, orchestration layer, or
claim that work was completed.

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
root for the current continuity document. Use a project-specific plan or task
directory only when the project contract already establishes one.

## Choose the shape

- **Shape A — full handoff:** a real decision, investigation, amendment, or
  multi-session thread that needs durable continuity.
- **Shape B — lightweight kickoff:** a small, fully diagnosed, low-blast-radius
  change with a short verification path.
- **Shape C — bounded task packet:** live, paid, production, or hard-boundary
  work that needs scope and permission gates before an agent starts. Shape C is
  an authorisation boundary, not a retrospective continuity report.

Read `references/TEMPLATE-handoff.md` for the selected shape. Do not fill a
Shape C packet by inheriting commands, paths, environments, or sources from a
different repository; confirm each one exists in the target project.

## Authoring rules

- Make the document self-contained for a fresh local or hosted agent session.
- State the objective, scope, constraints, authoritative sources, decisions,
  unresolved items, next actions, and evidence expectations.
- Record what was observed and how it was observed. A source link alone does
  not prove that the current runtime or artifact was checked.
- For completed work, list files changed, tests or probes run, results, and
  evidence paths. Say "not run" or "not verified" when appropriate.
- Put approval gates before the action they govern. Do not treat a handoff as
  retroactive authorization to deploy, publish, send, delete, spend, or modify
  a live system.
- Link to canonical documents instead of restating them. Keep the handoff
  concise enough to be read at the start of a new session.
- If an existing handoff changes, preserve important history: mark an
  amendment or investigation and do not silently rewrite a settled decision.
- Close the loop explicitly when the work is done. Do not delete the handoff
  merely because it is complete.

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
- Every source-of-truth path exists or is clearly marked as an external
  dependency.
- Facts, decisions, inferences, proposals, and open questions are distinct.
- Acceptance and evidence requirements are observable.
- Production, live-system, paid-system, publishing, and do-not-touch boundaries
  are explicit where relevant.
- No test, commit, deployment, inspection, or approval is claimed without
  evidence.
- The closing instructions tell the next agent what to preserve, verify, and
  report back.

