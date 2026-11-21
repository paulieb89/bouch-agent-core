---
name: handoff-authoring
description: Creates, updates, reviews and compacts handoffs — HANDOFF.md current-state documents, kickoffs and bounded task packets — so a fresh agent can continue without the original conversation. Use when work moves to another session, agent or provider; after a paid, live or publishing action, a changed decision or a reviewable artifact; before ending a session with uncommitted work; or when a handoff has become a dated journal.
---

# Handoff authoring

A handoff is the smallest project document that lets a fresh agent continue without the originating conversation. Default: one `HANDOFF.md` at the repo root (or the project's established location), rewritten in place so it describes now. Git keeps history; never append dated sections.

## Choose a shape

Use [references/TEMPLATE-handoff.md](references/TEMPLATE-handoff.md):

- **A — current-state handoff:** the standing document. A long, separately scoped thread may get its own Shape A file with a `status`, linked from the main one.
- **B — kickoff:** a small, diagnosed, low-risk change with a short verification path.
- **C — task packet:** live, paid, production or hard-boundary work that needs scope and permission gates before starting. Confirm every command, path and source exists in the target repo; never copy them from another repo.

## Update when

1. A paid, live, publishing or otherwise consequential action has run.
2. A decision in force has changed.
3. An artifact for the user to review has been produced.
4. A session is ending with uncommitted or untracked work.

Not on every commit; git records routine progress.

## Rules

- Self-contained for a fresh agent, and within the template's length budget. Compact it when it's over.
- Point to source files, commits, tests and evidence; don't copy them in.
- Keep facts, decisions, inferences, proposals, open questions and approvals distinct. Never turn an inference into a decision.
- When a decision changes, replace it and leave `superseded <date>: <old> → <new> (<reason>)`.
- Record `as_of` (date and the commit checked against). Annotate known in-flight paths; the real set comes from `git status`, and an unmentioned path is drift, not proof of absence.
- Say how each fact was observed. A link alone doesn't prove the runtime was checked.
- **Approvals and spend:** every consequential action gets a ledger line — date, action, the approval relied on and where it was given, cost, evidence path. If no approval can be found, write `approval not recorded`; never infer one. Keep only the open period; roll closed rows into the unit manifest or archive and derive totals.
- Approval gates go before the action. A handoff never authorises deploying, publishing, sending, deleting, spending or touching a live system after the fact. Record standing authorisations with scope, limit, grantor, date and expiry; each action cites one.
- When the work is done, close the loop explicitly. Don't delete the handoff.
- Don't create or update memory stores, catalogue records or session databases as part of writing a handoff.

## Contract vs handoff

The project contract (`AGENTS.md`/`CLAUDE.md`) holds stable rules plus one line pointing to the handoff. Current direction, figures and dated status belong in the handoff. If you find current state in the contract, propose moving it; edit the contract only with authorisation.

## Recurring production

For repeated units (episodes, releases, reports, batches), each unit keeps its own manifest: stage, sources, settings, costs, review outcome, release status. The project handoff indexes units by stage and holds only cross-cutting state: cadence, standing authorisations and spend against them, blockers, and the next unit's first action.

## Reading a handoff

Treat it as a dated claim. Before relying on it, run `git log <as_of>..HEAD -- . ':!HANDOFF.md'` and compare its in-flight list with `git status`. Unaccounted commits or paths mean it's stale: report the drift and update the handoff first.

## Compacting a journal-style handoff

1. Preserve the old text once: rely on git history and say so, or move it to a named, dated archive file. Never edit the archive.
2. Write a fresh Shape A. Re-verify each fact carried forward; unverified items become open questions.
3. Keep decisions in force; reduce superseded ones to one line each.
4. Send reusable lessons to `OBSERVATIONS.md` (`observation-log`).
5. Flag any current state found in the contract (see above).

## Final check

- [ ] A fresh agent can find the objective and the first safe action
- [ ] Describes the present; within the length budget
- [ ] `as_of` commit recorded; in-flight paths annotated
- [ ] Every consequential action has a ledger line
- [ ] Source paths exist or are marked external
- [ ] Facts, decisions, inferences and questions are distinct
- [ ] Acceptance criteria are observable
- [ ] Live, paid, publishing and do-not-touch boundaries are explicit where relevant
- [ ] No current state in the contract
- [ ] No test, commit, deployment or approval claimed without evidence
- [ ] Closing instructions say what to preserve, verify and report back
