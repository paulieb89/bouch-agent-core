# Development — bouch-agent-core

Maintainer notes. Not shipped as plugin context — Claude Code doesn't load
a plugin's root `CLAUDE.md` as project context when the plugin is installed
into someone else's project (only a skill's content loads, on invocation),
so this file is named to stay out of that path. It's for anyone developing
this repository itself.

## What this repo is

`bouch-agent-core` is a portable, provider-neutral **Claude plugin**: a
package of Skills (reasoning procedures) and reference docs distilling
agent-development methodology observed converging independently across
several unrelated project harnesses. It is not a harness or framework, and
ships no `/prime` implementation — see the "What this is not" section in
README.md for the full list of deliberate exclusions. Every Skill and
reference here is classified `PORTABLE AS-IS`: provider-neutral content,
with `.claude-plugin/plugin.json` — the only Claude-specific file — as the
sole exception; it also declares this package's one MCP server, a read-only
pointer to the Bouch Registry (see README.md's "Registry connection"
section). The portable root `plugin.json` and every Skill stay
provider-neutral regardless.

## Validating changes

Run the mechanical qualification checks after any edit:

```
scripts/validate-package.sh
```

This checks (in order): `plugin.json` conforms to the Agent Plugins v1.0.0
schema, each `skills/*/` validates against the Agent Skills spec (via
`agentskills/agentskills`, pinned to a specific commit — bump the
`AGENTSKILLS_REF` pin deliberately, not silently), `claude plugin validate
--strict` passes, the root `plugin.json` and `.claude-plugin/plugin.json`
have identical identity fields (`name`, `version`, `description`, `author`,
`keywords`), every `skills/*/` has a `SKILL.md`, and no stray
`plugin.json`/`marketplace.json` files exist outside the two expected
locations. Requires `claude`, `uvx`, and `python3` on PATH.

This script does **not** perform a real install/discovery trial against a
live client (e.g. `codex plugin marketplace add`) — that's a separate
release/acceptance test to run before a release, not on every edit.

## Structure and the dual-manifest requirement

```
bouch-agent-core/
├── plugin.json                  # portable root manifest (Agent Plugins spec)
├── .claude-plugin/plugin.json   # Claude plugin manifest — the only Claude-specific file
├── skills/
│   ├── harness-extension/       # extend the harness only when production proves a real gap
│   ├── environment-recon/       # bounded capability discovery, distinct from /prime
│   ├── prime-authoring/         # contract + checklist for a project's own /prime
│   └── evidence-freeze/         # preserve verified evidence without rewriting history
├── references/
│   ├── cross-domain-harness-model.md   # the 7-concept model (durable contract, derive-vs-persist, etc.)
│   ├── prime-contract.md               # frozen semantic contract for a project's own /prime
│   ├── derive-vs-persist.md            # rule for what to hand-maintain vs. always derive
│   ├── memory-placement.md             # which layer (repo/runtime vs. memory vs. contract) a fact belongs in
│   └── candidate-evidence-pattern.md   # distilled candidate/evidence lineage pattern (no code reproduced)
└── scripts/validate-package.sh
```

**Both `plugin.json` (root) and `.claude-plugin/plugin.json` must exist and
stay identical** on the shared identity fields. This is intentional
duplication, not drift: the root file is the portable Agent Plugins v1.0.0
manifest (readable by non-Claude clients like Codex directly), while
`.claude-plugin/plugin.json` is what Claude Code itself reads. When bumping
`version` or editing `description`/`author`/`keywords`, update both files
together — `validate-package.sh` will fail the "Portable <-> Claude identity
consistency" check otherwise. Do not add a `.codex-plugin/` directory or any
other compatibility-fallback manifest; Codex reads the portable root manifest
directly.

## Working in this repo

- **Every Skill's canonical copy lives here, exactly once.** If a Skill with
  the same purpose is ever found duplicated outside this package (e.g. a
  hand-written user-level copy), retire the outside copy in favor of loading
  this package — never maintain two copies in parallel, since they drift the
  moment either is edited independently.
- **This package is a distillation, not the source evidence.** Each
  reference here restates conclusions already reached and evidenced in
  project-local audits elsewhere (not part of this package). If this
  package's guidance and that outside evidence ever disagree, the evidence
  wins; update this package to match rather than treating it as
  independently authoritative.
- **Skills describe procedures to invoke when a task calls for them, not
  standing processes.** `environment-recon` is not a session-start ritual;
  `evidence-freeze` is not run after every commit; `harness-extension` is not
  for routine feature work. Each `SKILL.md`'s own "When to run this" section
  is the actual trigger condition — read it rather than assuming from the
  name.
- **`/prime` is intentionally not implemented here.** This package ships the
  contract (`references/prime-contract.md`) and an authoring/review
  checklist (`skills/prime-authoring/`); every consuming project owns its own
  `/prime`, because what counts as "current work state" is inherently
  project-shaped.
- Content changes to Skills or references should preserve the
  `PORTABLE AS-IS` classification: no provider-specific assumptions, no
  dependency on any particular project's local state, no code reproduced
  from the source workbenches that motivated a given reference doc.
