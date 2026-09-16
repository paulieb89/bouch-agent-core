# Prime contract

The frozen semantic contract for a project's `/prime` — what it must do,
what it must not do, and why. This document is the contract itself; the
`prime-authoring` skill turns it into an authoring/review checklist. No
shared `/prime` implementation is shipped anywhere in this package — see
"No universal implementation" below.

## Purpose

Prime derives the bounded current situation an agent needs to start useful
production work in a project, quickly and cheaply, from durable and
progressive sources already established for that project.

## Non-goals

- Prime does not perform environment discovery. It does not enumerate
  tools, rediscover capabilities, or re-validate configuration from scratch
  — that is recon's job (see `cross-domain-harness-model.md` §6 and the
  `environment-recon` skill).
- Prime does not ingest raw session transcripts or large logs.
- Prime is not a status-report generator and not a place to narrate the
  session.

## Discover vs. cite-and-pulse

The boundary that makes Prime cheap and trustworthy at once:

- **Cite**: state a small number of already-established routing facts
  (where an integration/server lives, which profile is active, what the
  relevant tools/Skills are) directly, because they are already durable/
  progressive knowledge — do not re-derive them.
- **Pulse-check**: cheaply verify that a known surface is actually live
  right now (e.g. one health check against a running service) —
  proportionate to the cost of being wrong, not a full capability sweep.
- **Drift → Recon**: if a pulse check fails or a cited fact turns out
  stale, that is a signal to hand off to recon, not to silently expand
  Prime into doing recon's job inline.

## Project/current-work orientation

Prime answers "what do I need to know to start working on this project
right now" — not "what is this project" in general and not "what happened
last session" in narrative form. Git state, in-flight work, and capability
routing are derived fresh each time (see `derive-vs-persist.md`); only
non-obvious, expensive, or repeatedly load-bearing facts get cited from
durable/progressive sources.

## Relevant capability-routing carve-out

Prime may cite capability-routing facts (which integration, which profile,
which Skill to reach for) when they are already durable knowledge for the
project — this is citation, not discovery, and is what keeps Prime from
re-deriving the same facts recon already established.

## Progressive disclosure

Prime surfaces only what is relevant to start the current slice of work; it
points at Skills and reference docs for anything task-specific rather than
inlining their content.

## Boundedness

Prime is deliberately small. A well-scoped Prime run should produce on the
order of single-digit summary lines, need only a couple of document reads
before the first production mutation, and do no broad environment/tool
rediscovery, no raw history ingestion, and no unnecessary tool enumeration.
Do not enlarge Prime based on a single session's convenience — enlarging it
defeats its purpose.

## Cross-domain acceptance evidence

This contract has transferred cleanly across more than one substantially
different domain without modification. In the transfer runs observed:

- a pulse check directly caused correct runtime recovery from a dead
  dependency, rather than the session proceeding on a stale assumption;
- a recon pointer (not Prime itself) directly led to a real, open
  production gap that motivated a `harness-extension` pass;
- known routing facts were sufficient without rediscovery;
- real production work began within a few minutes despite a genuinely
  broken dependency at session start.

## No universal implementation yet

Only the *semantic contract* above is claimed portable — not a shared Prime
implementation or schema. A contract transferring cleanly to two or more
substantially different domains is enough to freeze the contract itself; it
is not evidence for building a shared implementation or library on top of
it. Each project continues to own its own `/prime` command, authored against
this contract — see the `prime-authoring` skill.
