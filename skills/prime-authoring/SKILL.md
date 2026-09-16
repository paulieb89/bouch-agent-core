---
name: prime-authoring
description: Authoring guidance and checklist for writing or reviewing a project's own /prime command — the semantic contract it must satisfy, what to cite versus derive, and when drift should hand off to recon. Use when creating a new project's /prime, auditing an existing one, or deciding whether a session needs a full recon instead of a prime run. Does not itself implement /prime — every project owns its own.
---

# Prime authoring

This skill does not ship a `/prime` implementation. Every project keeps its
own — `/prime` is project-local because what counts as "current work state"
is inherently project-shaped (git state, in-flight branches, which routing
facts matter). What is portable is the *contract* a good `/prime` satisfies,
distilled in `references/prime-contract.md`. Use this skill to write a new
one or review an existing one against that contract.

## The contract, in one paragraph

Prime derives the bounded current situation an agent needs to start useful
production work in a project, quickly and cheaply, from durable and
progressive sources already established for that project. It does not
perform environment discovery (that's recon's job), does not ingest raw
session transcripts, and is not a status-report generator.

## Authoring checklist

When writing or reviewing a project's `/prime`, check it against each line:

- [ ] **Derives, does not discover.** It reads git state, in-flight work,
      and similar fresh-each-time facts directly — it does not enumerate
      tools, re-validate configuration, or rediscover capabilities from
      scratch.
- [ ] **Cites a small number of routing facts.** Where the MCP server lives,
      which profile is active, which Skill/reference to reach for — stated
      directly because they're already durable/progressive project
      knowledge, not re-derived each run.
- [ ] **Pulse-checks, doesn't sweep.** At most a cheap, proportionate check
      that a known surface is actually live right now (one health check
      against a running service) — not a full capability audit.
- [ ] **Hands off drift to recon.** If a pulse check fails or a cited fact
      turns out stale, that's a signal to invoke `environment-recon`, not to
      silently absorb recon's job into Prime.
- [ ] **Stays small.** A good Prime run produces on the order of single-digit
      summary lines and needs only a couple of document reads before the
      first production action. If Prime keeps growing because "it was
      convenient this one session," that's a sign of contract drift — pull
      the addition back out into a reference doc or a Skill instead.
- [ ] **Points, doesn't inline.** Task-specific detail lives in Skills and
      reference docs; Prime surfaces only what's relevant to start the
      current slice and points at where to read more.
- [ ] **Answers the right question.** "What do I need to know to start
      working on this project right now" — not "what is this project" in
      general, and not "what happened last session" as narrative.

## Invariant vs. project-specific

What transfers across any project's `/prime`:

- the derive-vs-cite-vs-pulse boundary itself;
- the non-goals (no discovery, no transcript ingestion, no status theater);
- the definition of "drift" as the recon hand-off trigger;
- the boundedness expectation.

What is necessarily project-specific and stays out of this skill:

- which files/commands actually get read (git log, a backlog file, a
  hotspots scan — whatever that project's authoritative sources are);
- which routing facts are worth citing (MCP server location, active
  profile, which Skills exist);
- the concrete pulse-check performed, if any (a health endpoint, a version
  read, a smoke call) — shaped entirely by what that project can cheaply
  verify.

## Working with recon

Prime and recon are deliberately different sizes and different triggers.
Prime runs near the start of most working sessions and stays cheap; recon
runs rarely, only when the environment is genuinely unfamiliar or a pulse
check has just failed. A `/prime` that tries to also do recon's job will
either become slow and sprawling, or will silently trust stale facts. See
`environment-recon` for that boundary in more detail, and
`references/prime-contract.md` for the full frozen contract this checklist
is derived from.
