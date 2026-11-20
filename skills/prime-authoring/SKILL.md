---
name: prime-authoring
description: Writes or reviews a project's own /prime command against the Bouch Prime contract — what to derive, cite and pulse-check, and when to hand drift to recon. Use when creating or auditing a project's /prime, or when deciding whether a session needs recon instead. Every project owns its own /prime; none ships here.
---

# Prime authoring

Prime answers "what do I need to start working on this project right now", in a few lines, cheaply. It is not environment discovery, a project overview or a session narrative.

## Contract

- **Derive** live: git state, in-flight work, anything the repo or runtime can answer.
- **Cite** a few routing facts that are already durable (where the MCP server lives, the active profile, which Skill to use). Don't rediscover them.
- **Pulse-check** at most one or two known surfaces, cheaply (a health endpoint, a version read).
- **Check the handoff** if the project keeps one: run `git log <as_of>..HEAD -- . ':!HANDOFF.md'` and compare its in-flight list with `git status`. Report unaccounted commits or paths as drift; never present a stale handoff as current state.
- **Hand drift to recon.** A failed pulse or a stale cited fact triggers `capability-gap`. Prime doesn't absorb recon's job.
- **Stay small:** fewer than ten summary lines and no more than two document reads before the first piece of real work. Point to Skills and docs for detail. Don't grow Prime for one session's convenience; move the addition into a doc or Skill.
- **Never** enumerate tools, revalidate configuration from scratch, or read raw transcripts or large logs.

## Review checklist

- [ ] Derives live state; doesn't store or rediscover it
- [ ] Cites only routing facts that are already durable
- [ ] Pulse check is cheap and proportionate
- [ ] Checks handoff freshness (if the project keeps a handoff)
- [ ] Hands drift to recon
- [ ] Under ten lines of output; at most two doc reads before work starts
- [ ] Points to detail instead of inlining it

## Decide per project

Which files and commands to read, which routing facts to cite, and what pulse check (if any) the project can do cheaply.
