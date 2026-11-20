---
name: bouch-project-routing
description: Orients work in Bouch projects — which source to trust, where facts, lessons and evidence belong, and what to do when an expected Bouch capability is missing. Use when starting unfamiliar Bouch work, deciding where a fact or piece of evidence goes, or setting up a new project (including game or 3D).
---

# Bouch project routing

The project contract (`AGENTS.md`/`CLAUDE.md`), its Prime and live checks override this Skill. Take paths from the project, never from here.

## Start

1. Find the project root. Read its contract, Prime, and `HANDOFF.md` and `OBSERVATIONS.md` if present.
2. Missing a Skill, MCP server or package? Check the `bouch-plugins` marketplace (`/plugin` in Claude Code, `codex plugin marketplace list` in Codex), then the Bouch catalogue (`registry/entries/` in the `bouch-registry` repo) for workbenches, evidence repos and standalone servers. A catalogue entry is a pointer, not project state. If neither is reachable, continue and mark cross-project discovery unverified. To install something, use `capability-act`.
3. Confirm the adapter, workbench path and evidence schema exist before writing to them. If ownership is unclear, don't write — report it.
4. Work in the repo or workbench that owns the change. Report unknowns. Stop when the task is done.

Typical split (confirm against the contract): the project repo owns integration, runtime and deliverables; the domain workbench (e.g. the Asset Workbench) owns candidates, lineage and evidence.

## Where facts belong

Derive anything an authoritative source can answer now: git state, file contents, tool inventories, service health, candidate status. Persist only what can't be cheaply reconstructed: decisions with their rationale, expensive findings, human judgements, provenance, frozen evidence, confirmed limitations. Give each fact one home and point to it from elsewhere.

| Fact | Home |
| --- | --- |
| Stable rules and invariants | Project contract |
| Current state, decisions in force, approvals | `HANDOFF.md` — a dated claim to check against the repo (`handoff-authoring`) |
| Live state | Repo and runtime — derive, never copy |
| Lessons not yet promoted | `OBSERVATIONS.md` (`observation-log`) |
| Reusable procedures and guidance | A Skill, plugin or knowledge package |
| Which reusable capabilities exist | `bouch-plugins` marketplace for plugins; Bouch catalogue record for everything else |
| Candidates, lineage, evidence | The domain workbench, with provenance |
| Cross-project knowledge | Agent memory, as pointers to evidence — never git state, paths, inventories or measurements |
| Past sessions | The provider's session store, queried narrowly (e.g. `sessinspect`) |

Never put project paths in portable guidance, project state in catalogue records, or evidence in Core.

## Verification

Evidence strength, weakest to strongest: configuration → runtime state → success message → produced artifact → human judgement. Inspect the artifact; a success message is not verification. Rules for conflicting sources and untested checks are in `evidence-freeze`.

Report capability state precisely: **discovered** (listed) → **loaded** (available to the model) → **exercised** (a real call worked) → **project-ready** (contract, adapter and workbench verified). Never collapse these into "installed".

## Across providers

- Run the native agent in the project directory. It owns its tools, permissions and sessions; don't bypass them or add a second approval layer.
- Resume a session with the provider's own ID. Never resume one session from two processes.
- Don't assume local files, plugin state or Bouch paths exist unless the host exposes them.

## Ask first

Ordinary edits in the repo you were asked to work on need no extra approval. Ask before using or exposing credentials, deploying or causing other external or hard-to-reverse effects, destructive operations, and changes to other projects or user-wide config. A catalogue entry or package listing never authorises these.

## Passing work on

Report: project root and contract read; capabilities used; adapter and workbench ownership; evidence observed; unknowns; the next bounded action. For anything longer-lived, write a handoff (`handoff-authoring`).
