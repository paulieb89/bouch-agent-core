---
name: observation-log
description: Capture reusable lessons from a working session into the project's observation log, and review staged observations for promotion into durable knowledge. Use when a correction, expensive lesson, stale guidance, or repeated workaround should outlive the session — and when asked to review, promote, or clean up the log, or to mine past session transcripts for candidate lessons.
---

# Observation log

Sessions produce lessons that are worth more than the session: a correction
the next agent should not need twice, a finding that took real investigation,
a documented instruction that turned out to be stale, a workaround repeated
by hand. The observation log is the project's staging area for those
lessons — a plain file, `OBSERVATIONS.md` at the project root, that a fresh
agent can read cheaply and a human can review.

It is staging, not storage. An observation becomes durable knowledge only by
being promoted (see Review below); until then it is a provisional note
attached to whatever it concerns. If the project already keeps an equivalent
staged-observation convention under a different name or location, use that
convention and do not create a second file.

## When to capture an observation

Capture on these triggers, and only these:

1. **Correction** — the user or a supervisor corrected the approach in a way
   that is not already written down in project guidance, a Skill, or a
   reference. Do not wait for a repeat: if it was worth saying once, it is
   worth recording once.
2. **Expensive lesson** — a finding that took real investigation, a failure,
   or an incident to produce, and cannot be cheaply re-derived.
3. **Stale guidance** — a Skill, reference, contract, or handoff that
   conflicted with observed reality. Record it as type `conflict` so the
   stale source can be corrected, not silently worked around again.
4. **Repeated workaround** — a manual step repeated across tasks that could
   plausibly become a procedure, tool, or documented convention.

Do not capture derivable state — git status, current file contents, tool
inventories, whether a service is up right now. Derive those live
(`references/derive-vs-persist.md` covers the rule; `references/memory-placement.md`
covers which layer a fact belongs in). Do not capture secrets, credentials,
or raw transcript material — point at evidence, never copy it.

## Capture procedure

1. Prefer the project's established convention. If one exists, append there
   and stop. Otherwise create `OBSERVATIONS.md` at the project root using
   the template bundled with this skill (`references/TEMPLATE-observations.md`
   inside this skill's own directory).
2. Append one entry per observation, in the template's field order: id,
   status `OPEN`, target (the Skill, reference, or area it applies to), type,
   what was observed, an evidence pointer, and the proposed rule.
3. Keep the entry short — a few lines, written so a fresh agent can act on
   it without the originating conversation. Write the observation, not the
   narrative of discovering it. Leave `resolution` unset until review.
4. When a log is first created in a project, note its location in the
   project's durable contract (`CLAUDE.md`/`AGENTS.md`, Prime, or the
   project's equivalent) so agents that never load this skill still check
   it. One line is enough.
5. Resume the task. Capturing is a pause of seconds, not a phase of work.

## Applying open observations

Before relying on a Skill, reference, or documented convention in this
project, check the log for `OPEN` entries tagged to it. An `OPEN` entry is
provisional: it records what happened once, with its evidence — follow it
where it looks sound; when it proves or fails in use, record the
outcome on the entry itself (a line under `observed:` or `evidence:`),
so review can act on it.
An `OPEN` entry never outranks live evidence; when they conflict, evidence
wins and the entry should be marked for review rather than followed.

## Review and promotion

Review the log on request — the user asks, a handoff calls for it, or the
log has accumulated enough `OPEN` entries to audit. For each entry:

1. Check whether the observation is still true. A `conflict` entry against a
   source that has since been fixed, or a lesson the current artifact
   contradicts, is marked `STALE` — never silently deleted.
2. Propose the promotion target as a draft: a line or gotcha in the relevant
   Skill or reference, a fix to stale guidance, a durable-contract entry, or
   dismissal with a reason. Promotion edits are *proposed*, not applied —
   the user approves which changes get made.
3. Mark the entry `PROMOTED` with where the promoted content landed, or
   `DISMISSED` with the reason. The log keeps the record either way.

Promotion is also where the entry's scope gets decided: project-local
lessons promote into the project's own docs; a lesson that proved out
across projects is a candidate for the shared package that owns the topic —
proposed as a change there, not copied in.

## Mining past sessions

When asked to harvest session history — for example to seed a new log —
the same four triggers apply retrospectively. Claude Code and Codex keep
durable session transcripts; a read-only inspector such as `sessinspect`
answers bounded questions over Claude Code transcripts (what tools ran,
what failed, which files changed) without loading raw transcripts into
context. For other providers, read the provider's own session store by
path rather than assuming the inspector covers it.

1. Scope the harvest: which sessions, which project, which period — a
   bounded slice, not "everything ever".
2. Query for signal, not narrative: corrections, error→fix sequences,
   repeated commands, reverted changes, user redirects. Reading whole
   transcripts end-to-end is the expensive way to find few lessons.
3. Draft each candidate as an `OPEN` entry exactly as live capture would,
   with its provenance citation (`session:line` or equivalent) as the
   evidence pointer, and mark it as extracted rather than witnessed —
   mining infers, it does not observe.
4. Dedupe against existing log entries before proposing; harvested
   lessons are disproportionately likely to already be known.
5. Present candidates for review like any other `OPEN` entries. A harvest
   proposes; it does not promote.

## What this is not

- Not a memory service, database, or hosted store. It is one Markdown file
  owned by the project; nothing here requires an MCP server, an index, or a
  sync mechanism.
- Not auto-promotion. `OPEN` entries stage candidates; a human decides what
  becomes durable. Nothing in this skill edits a Skill, reference, or
  contract on its own.
- Not a transcript, plan, or handoff. Handoffs carry project state forward
  (see `handoff-authoring`); observations carry reusable lessons. A fact
  that only matters to this project's next session belongs in a handoff or
  project doc, not here.
- Not a standing ritual. Capture fires on the triggers above, not at the
  end of every session; an empty log after honest work is a correct result.
- Not a substitute for fixing stale guidance directly. When an observed
  conflict clearly identifies a documentation bug and the fix is already
  authorised, fixing the source beats logging a workaround for it.
