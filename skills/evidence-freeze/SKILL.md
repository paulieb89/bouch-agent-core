---
name: evidence-freeze
description: Preserves evidence of verified work so it can be trusted and pointed back to later — deciding what counts as evidence, pinning a known-good state and never rewriting it. Use after a real verification pass succeeds and the result is worth returning to (a qualified baseline, comparison point or delivered artifact), not after every commit.
---

# Evidence freeze

## Sequence

1. **Verify first.** Run the domain's own check that inspects the produced artifact, not the step that reports it ran.
2. **Keep the evidence durably.** Identify what proves correctness here (a render, a measurement file, a fixture output, a hash-checked candidate, a smoke-test result) and make sure it is tracked, not a regenerable intermediate.
3. **Pin it where useful.** Commit, and tag if it's worth returning to, when existing authorisation allows. Name tags for what was qualified, not when. If committing isn't authorised, leave the evidence in place and report its state. Project freeze rules override this.
4. **Never rewrite frozen history.** No amending, rebasing or force-pushing over a frozen tag. If a frozen state was wrong, say so in a new commit.
5. **Keep the index separate.** A small, maintained doc points to where evidence lives. Never edit the frozen record to keep it "up to date".

## What counts

Not evidence: a success message with no inspection; a regenerable build output, cache or scratch render (gitignore these); a narrative written after the fact.

Apply these in proportion to the claim:

- **Record observation and interpretation separately.** What the instrument returned is evidence; your conclusion is a claim.
- **A clean result proves nothing until the check has caught a known fault.** For strong claims or untested checks, seed the fault on a fixture or copy and watch the check fail. Never seed faults in production or shared systems. If you can't calibrate, record the result as uncalibrated.
- **When sources conflict:** running artifact > installed package or lockfile > version-matched docs > other prose > memory. Don't claim runtime correctness from source reading when the system can be run.

Elsewhere (memory, handoffs), cite frozen evidence by path; don't restate its numbers.

For workbenches that iterate on candidates, see [references/candidate-evidence-pattern.md](references/candidate-evidence-pattern.md).
