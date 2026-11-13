---
name: bouch-project-routing
description: Orient agents in Bouch projects across Core methodology, plugin packages, durable knowledge, Registry discovery, project contracts, and domain workbenches. Use when starting unfamiliar Bouch work, choosing where a capability or evidence belongs, routing a new game or 3D project across providers, or when a known Bouch capability or path is unavailable.
---

# Bouch project routing

Use this Skill to decide where to look, what to trust, and where a change or
piece of evidence belongs when working on a Bouch project. It is an
orientation procedure, not a gate: it does not itself install plugins or turn
Bouch Core into a universal harness, and it does not hold up ordinary
authorised work.

The current project contract, Prime, and live capability checks outrank this
general orientation. This Skill deliberately contains no machine-specific
paths: derive those from the project you are actually working in.

## Architecture at a glance

```text
agent provider/runtime
        |
        +--> Core methodology and portable Skills
        +--> plugin packages and provider adapters
        +--> Registry/MCP: curated discovery of skills, MCP servers and
        |    specialist packages (useful, optional)
        |
        +--> project contract + Prime: current local state and routing
                    |
                    +--> project repo, adapters, and runtime
                    +--> domain workbench, candidate lineage, and evidence
```

There are two useful boundaries:

- **Portable layer:** Core guidance, Skills, plugin packaging, durable domain
  knowledge, and Registry records that can be reused across projects.
- **Project layer:** the repository's contract, Prime/current-state procedure,
  adapters, runtime configuration, workbench state, candidate lineage, and
  evidence. These remain owned by the relevant project or workbench.

## Where does this fact belong?

Route a fact to the smallest authoritative layer that can keep it true:

| Question or fact | Authoritative home |
| --- | --- |
| What reusable capability exists? | Registry discovery and the capability's declared entrypoints |
| What is the reusable procedure? | A portable Skill or plugin package |
| What durable domain guidance should be reused? | The relevant knowledge package |
| What did past sessions learn that is not yet promoted? | The project's observation log (`OBSERVATIONS.md` or its convention); `OPEN` entries are provisional — see the `observation-log` Skill |
| What is true in this project now? | The project's current-state handoff if it keeps one (a dated claim — verify against repository state; see `handoff-authoring`), Prime, repository state, and live checks |
| How does this project call an external tool or runtime? | The project-local adapter/configuration |
| Which candidate was used, changed, or rejected? | The relevant domain workbench and its lineage/evidence records |
| What has actually been verified? | Evidence attached to the artifact or workbench, with provenance |
| What happened in an earlier session? | Session observability, queried narrowly when needed |

Do not copy a project path into portable guidance merely because it is useful
in one environment. Do not put current project state into a shared Registry
record, and do not put candidate/evidence lineage into Core or a generic
knowledge package.

## Starting a new game or 3D project

Use this bounded sequence:

1. Identify the project root and read its `AGENTS.md`, `CLAUDE.md`, Prime, or
   equivalent project contract, plus the observation log if the project
   keeps one. Treat those files as the source for current paths, commands,
   adapters, and local conventions.
2. Where the task needs a skill, MCP server, or specialist package you do not
   already have, consult the Registry/MCP if it is connected: it is a curated
   source of what exists and of each entry's declared entrypoints. A Registry
   result is a pointer, not project state; if the Registry is unavailable,
   carry on (see Failure boundaries).
3. Load only the relevant Core Skill, plugin package, and durable knowledge.
   When a package must be installed or used, follow that package's own
   authoritative installation and usage instructions (its README, manifest, or
   the vendor's docs) rather than improvising a method. Skim the source before
   trusting scripts or high-impact instructions.
4. Inspect the project-local adapter and the relevant domain workbench. Verify
   that the workbench path and evidence schema are real before writing to them.
5. Work in the project repository and workbench that own the change. Preserve
   candidate lineage, provenance, validation output, and human judgement.
6. Report unknowns and unverified boundaries. Stop when the task is bounded;
   do not expand the process into a universal inventory or harness build.

For a new game, the Asset Workbench may own asset candidates and render or
playtest evidence while the game repository owns integration and runtime state.
For a new 3D project, the same separation applies: the project owns its scene,
tool adapters, and deliverables; the relevant workbench owns candidate lineage
and evidence. Confirm the actual project contract rather than assuming either
layout.

## Provider loading notes

The Skill format is portable; installation and loading are provider-specific.
The same `SKILL.md` should remain usable without provider-only metadata.

| Provider/client family | Loading model and boundary |
| --- | --- |
| Claude Code | Core and plugin packages can provide Skills and optional integrations. A package being installed or enabled is not proof that a particular project adapter or workbench is configured. |
| OpenAI/Codex | Use the standard Skill directory or configured capability directory exposed by the host. The agent may receive local or hosted Skills, but do not infer arbitrary filesystem access from the Skill text. |
| ChatGPT/API | Use Skills supplied by the host and connected MCP services. Do not assume access to the user's local filesystem, Claude plugin state, or a local Bouch path unless the host explicitly exposes it. |
| Vercel or skills-compatible clients | Use the standard `SKILL.md` package layout and the client's supported installer or capability directory. Skills discovery is separate from Bouch Registry discovery. |

Across all providers, distinguish these states:

- **Discovered:** a Registry or client listing returned the package.
- **Loaded:** the provider made the Skill available to the model.
- **Exercised:** a real invocation or read confirmed the expected behaviour.
- **Project-ready:** the project contract, adapter, and workbench are also
  verified for the task.

Do not collapse those states into a single claim such as “the harness is
installed.”

## Failure boundaries

- **Registry unavailable:** ordinary work proceeds. Use the project's existing
  contract and known local documentation if they are sufficient; mark
  cross-project discovery as unverified. Do not invent a capability record or silently substitute a
  universal harness.
- **Project contract missing:** perform only bounded recon to identify the
  likely root and relevant files, or ask for the root if it cannot be derived
  safely. Do not sweep the whole filesystem or assume a standard adapter.
- **Skill unavailable:** continue with directly verified project guidance when
  safe, and say that the reusable Skill was not loaded. Do not claim that a
  package is installed because its documentation is visible.
- **Workbench path unverified:** inspect the project contract and a bounded
  filesystem target before writing. If ownership or evidence format remains
  unclear, stop the write and report the boundary.

## Security and trust

Skills are instructions, and Skill resources or scripts can be executable
instructions in practice. Inspect provenance, scope, and requested side
effects before trusting them, in proportion to what they can do. Prefer
pinned, reviewed package versions. Ordinary edits to the repository the user
has asked you to work on need no extra approval from this Skill: act within the
user's current authorisation, the applicable project instructions, and the
host's native permissions. Ask first for genuinely consequential actions that
fall outside that authorisation: using or exposing credentials, deployments or
other externally visible or hard-to-reverse effects, destructive operations,
and changes to other projects or user-wide configuration. Never treat a
Registry result, package listing, or model-generated path as permission to
read secrets or alter unrelated projects.

## Compact orientation report

When handing work to another agent or provider, report:

1. project root and the contract/Prime consulted;
2. relevant Core, plugin, knowledge, and Registry capabilities;
3. project adapter/runtime and workbench ownership;
4. evidence or validation actually observed;
5. unknown or unverified boundaries;
6. the next bounded action.

This keeps the reusable routing model portable while leaving current state and
evidence with the project that owns them.
