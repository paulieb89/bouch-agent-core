---
name: observation-log
description: Captures lessons from a session into the project's OBSERVATIONS.md and reviews staged entries for promotion into durable guidance. Use when a correction, expensive finding, stale instruction or repeated workaround should outlive the session, or when asked to review, promote or clean up the log, or to mine past session transcripts for lessons.
---

# Observation log

`OBSERVATIONS.md` at the project root stages lessons for human review. Entries are provisional until promoted. If the project already has an equivalent convention, use that instead.

## Capture triggers (only these)

1. **Correction** that isn't already written in project guidance, a Skill or a reference. Record it the first time.
2. **Expensive lesson:** it took real investigation, a failure or an incident, and can't be cheaply re-derived.
3. **Stale guidance:** a Skill, reference, contract or handoff contradicted reality. Use type `conflict`.
4. **Repeated workaround** that could become a procedure, tool or convention.

Never capture derivable state (git status, file contents, tool inventories, service health), secrets or raw transcript text; point to evidence instead. An empty log after honest work is correct. If a conflict is clearly a documentation bug and fixing it is authorised, fix the source instead of logging it.

## Capture

1. If `OBSERVATIONS.md` doesn't exist, create it from [references/TEMPLATE-observations.md](references/TEMPLATE-observations.md) and add one line to the project contract pointing to it.
2. Append an entry in template order: id, status `OPEN`, target, type, basis, observed, evidence pointer, proposed rule. Keep it to a few lines — the observation, not the story. Leave `resolution` empty.
3. Resume the task.

## Using OPEN entries

Before relying on a Skill, reference or convention, check for `OPEN` entries targeting it. Follow them where they look sound and note the outcome on the entry. Live evidence beats an entry; if they conflict, flag the entry for review.

## Review

On request, or when a handoff calls for it. For each entry:

1. Is it still true? If the source has been fixed or the lesson no longer holds, mark it `STALE`. Never delete entries.
2. Draft the promotion: a line in the relevant Skill or reference, a fix to stale guidance, a contract entry, or dismissal with a reason. Propose it; the user approves.
3. Mark it `PROMOTED` (with where it landed) or `DISMISSED` (with the reason).

Project-local lessons promote into project docs. A lesson proven across projects is proposed as a change to the shared package that owns the topic.

## Mining past sessions

When asked to harvest session history:

1. Scope it: which project, which sessions, which period.
2. Query for signal — corrections, error→fix sequences, repeated commands, reverts, user redirects — instead of reading whole transcripts. For Claude Code, `sessinspect` answers these queries; for other providers, read their session store directly.
3. Draft candidates as `OPEN` entries with `basis: extracted` and a `session:line` evidence pointer.
4. Dedupe against existing entries, then present them for review. A harvest proposes; it never promotes.
