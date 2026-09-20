---
name: evidence-freeze
description: Practice for preserving authoritative evidence once work has been produced and verified — committing/tagging a known-good state, never rewriting that history, and keeping current routing docs distinct from frozen historical experiment records. Use after a real verify pass succeeds and the result is worth being able to point back to later, not after every commit.
---

# Evidence freeze

Once a piece of work has been produced and genuinely verified (not just
"the step reported success" — see the produced-artifact-over-echoed-success
point in `references/cross-domain-harness-model.md`), the evidence that it
worked is itself worth protecting. This skill is the discipline for doing
that without turning it into git ceremony for its own sake.

## The sequence

1. **Produce and verify.** Run the domain's own verification — the thing
   that actually inspects the produced artifact/output, not the step that
   merely reports it ran. Do this before considering anything "done."
2. **Preserve the authoritative evidence.** Identify what actually
   constitutes the evidence of correctness for this domain — a rendered
   artifact, a measurement file, a fixture output, a qualified dataset — and
   make sure it is committed, not left as an untracked or regeneratable
   intermediate.
3. **Commit/tag the known state.** Create a commit (and a tag, if the state
   is worth being able to name and return to later) that captures this
   specific verified state. The tag name should say what was qualified, not
   just when.
4. **Do not rewrite that history.** Once evidence has been frozen, treat it
   as append-only. Fix problems forward with a new commit/candidate, not by
   amending or force-pushing over a tagged evidence state — the whole point
   is being able to trust that a frozen tag still means what it meant when
   it was cut.
5. **Distinguish current routing from historical record.** A frozen
   evidence commit/tag is a historical record of what was true then, not a
   live index of what's true now. Keep a small number of current,
   maintained routing/index docs pointing at *where* authoritative evidence
   lives, separately from the (immutable) evidence itself. Don't let the
   historical record quietly become the thing people read for current
   state, and don't edit the historical record to keep it "up to date" —
   that defeats its purpose.

## What counts as evidence, and what doesn't

Evidence is domain-shaped — a render, a loudness measurement, a headless
fixture screenshot, a hash-verified candidate file, a live-endpoint smoke
test result. It is not the same thing as:

- a step's own "success" echo, absent independent inspection;
- a regeneratable intermediate (a build output, a cache, a scratch render)
  that the pipeline can reproduce on demand — gitignore these, don't freeze
  them;
- a narrative summary of what was done, written after the fact with no
  inspection behind it.

Three rules decide whether what you have is strong enough to freeze.

**A recorded observation is not an interpretation.** Keep the two separable
in the record. What the instrument returned is evidence; what you concluded
from it is a claim that the reader may disagree with. Do not let inference
become fact by being written down in the same voice.

**A null result is not trustworthy until the instrument has produced a known
positive.** A check that has only ever passed has not been shown capable of
failing. Before a clean run counts as evidence, seed the fault it claims to
catch and watch it fail. This is the difference between a green suite and a
verified one: a suite can stay green for as long as it has no assertion
against a known value.

**When sources conflict, prefer the strongest available:**

    running artifact
      > installed package / lockfile
        > version-matched authoritative documentation
          > other prose
            > memory

Use the strongest that is practical, not the most convenient. Do not claim
runtime, integration or user-visible correctness from source inspection
alone when the real system can be executed or inspected, and when
correctness depends on version-specific state, read the installed artifact
rather than what the documentation says it should be. Documentation does not
prove the installed surface — `environment-recon` covers enumerating that
surface, and `references/derive-vs-persist.md` covers not copying what it
can report.

## Relationship to memory and derive-vs-persist

Frozen evidence is itself an instance of "persist what cannot cheaply be
reconstructed" (`references/derive-vs-persist.md`). Once it exists, prefer
citing it over re-describing its contents from memory — a memory record
that names specific measurements or file paths from a frozen evidence set
should point at that evidence rather than duplicate it, since the frozen
record is authoritative and the memory copy will drift. See
`references/memory-placement.md` for the fuller boundary between
repository/runtime evidence, Prime, memory, and raw history.

## What this is not

- Not a mandate to tag every commit. Freeze evidence when a result is worth
  being able to point back to later — a qualified baseline, a comparison
  point, a delivered artifact — not as routine housekeeping.
- Not permission to skip `--no-verify`/force-push style shortcuts to "clean
  up" a frozen state. If a frozen tag turns out to be wrong, say so
  explicitly in a new commit rather than silently correcting the old one.
- Not a replacement for the domain's own verification step. Evidence-freeze
  starts after verification has already happened.
