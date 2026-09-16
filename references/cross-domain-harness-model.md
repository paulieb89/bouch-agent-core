# Cross-domain agent-harness model

Distilled from auditing several independently evolved agent-harness domains
and observing where they converged despite no shared implementation. This is
the portable conceptual model — the domain audits and per-domain evidence
that produced it stay in their own project repositories; this document does
not restate them.

## The seven concepts

**1. Durable contract** — small, load-bearing instructions/configuration
that must be present routinely: a project's `CLAUDE.md`/`AGENTS.md`,
settings/permissions, project integration registration, small invariant
statements. Live or derivable state does not belong here.

**2. Progressive knowledge** — relevant only under particular tasks or
paths: Skills, path-scoped rules, reference docs, detailed domain knowledge.
Prefer retrieval/invocation over permanent context.

**3. Capabilities** — the surfaces through which an agent perceives or acts.
Preference order where practical: native capability → existing CLI/API/
protocol → domain-specific integration → thin adapter over an existing
service → custom infrastructure only for a demonstrated gap. Availability
alone does not justify use — a capability's credibility/calibration matters
too (see `prime-contract.md`'s recon/pulse distinction, and the
`environment-recon` skill).

**4. Workbench / evidence** — domain-native mechanisms that determine
whether work is actually correct: rendering/build fixtures, audio or signal
analysis, schema/contract audits, transport smoke tests. Do not unify their
schemas across domains — each domain's evidence stays domain-shaped (see
`candidate-evidence-pattern.md` for why no universal schema is proposed
here).

Evidence tends to progress through the same general tiers regardless of
domain:

```
configured/project state → runtime state → operation reports success
  → produced output artifact → semantic/perceptual judgement
```

The produced artifact can be more authoritative than apparently-correct
project/runtime state — a clean success echo and plausible-looking
configuration have both been observed to coexist with a genuinely wrong
produced output. Verification that stops at the success echo, without
inspecting the artifact itself, is not verification.

**5. Governance** — use deterministic enforcement (hooks, gates) only where
a constraint is both irreversible-or-materially-hard-to-reverse *and*
mechanically checkable without model judgement: deploy gates, protected/
frozen evidence paths, cross-repository mutation boundaries. Do not use
deterministic gates to narrate normal workflow or encode judgement-heavy
rules — that belongs in a Skill instead (see the `harness-extension` skill).

**6. Derivation / Prime** — Prime derives the bounded current situation
needed to start useful work; it does not perform environment discovery. The
boundary:

- **Recon** discovers/enumerates capabilities, validates configuration,
  discovers limitations, calibrates signal credibility.
- **Prime** derives current-work state, cites a small number of
  already-established routing facts where directly relevant, cheaply
  pulse-checks known surfaces, and never rediscovers/enumerates the
  environment.

Full detail in `prime-contract.md`. This boundary has transferred across
more than one substantially different domain without modification, which is
what qualifies it as frozen rather than provisional.

**7. Observability & distilled history** — an information lifecycle:

```
raw observation/history → selective distillation
  → curated evidence / learned facts → promotion when repeatedly load-bearing
  → durable/project knowledge
```

Raw session transcripts and large logs normally stay outside working
context. An observability tool that answers a specific question by querying
history — rather than injecting transcripts into new sessions — is an
implementation of this lifecycle's first step, not a separate architectural
layer. Auto-memory, curated ledgers, and experiment READMEs are
implementations of "distilled knowledge" at the second/third step above, not
separate universal architectural layers of their own.

## Derive vs. persist

Covered in full in `derive-vs-persist.md`. In short: if an authoritative
source can cheaply answer a question now, derive it rather than
hand-maintaining a copy. Persist only what cannot cheaply be reconstructed.

## Production-driven self-extension

A harness gap gets closed only when production work actually hits it,
proven by evidence (not source-reading alone), checked against native/
existing capabilities first, extended by the smallest useful addition,
verified through the real client/runtime, and then the agent returns to
production immediately — stopping rather than recursively chasing the next
capability gap the investigation turned up. This is captured as the
`harness-extension` skill, invoked when warranted rather than applied as a
standing process.

## What is explicitly NOT generalized here

- No shared Prime *implementation* or schema across projects — only the
  semantic contract is claimed portable, and only after transferring
  cleanly to more than one substantially different domain without
  modification. Every new domain adopting it unmodified is further
  confirming evidence, not a reason to build a shared implementation.
- No unified evidence/workbench schema across domains — each domain's
  verification stays domain-native.
- No generic agent framework — this model describes how independently
  evolved harnesses already converged, not a library to build.
- No mandatory end-of-session retrospective automation — if evidence ever
  justifies one, it should surface review candidates for a human/agent to
  act on, not auto-mutate the harness on its own.
