# AGENTS.md

Guidance for coding agents working on this repository.

## What this repo is

`bouch-agent-core` is a portable, provider-neutral Claude/Agent Plugin: Markdown Skills (reasoning procedures) plus reference docs. There is no application code, build step, or test suite. `README.md` ("What this is not") and this file are the authoritative contract; read both before structural changes.

## Stack

Markdown (`SKILL.md` with YAML frontmatter, references), JSON manifests (Agent Plugins v1.0.0, Claude plugin), one Bash validation script. No package manager or dependencies to install.

## Commands

```
scripts/validate-package.sh   # full package qualification; run after every edit
claude --plugin-dir .         # load the package into a local Claude Code session for manual testing
```

`validate-package.sh` requires `claude`, `uvx`, `python3` on PATH and network access (fetches schemas and the pinned `agentskills/agentskills` commit). It runs everything in one pass; there is no single-check mode. It checks: root `plugin.json` and `mcp.json` against Agent Plugins v1.0.0 schemas, each `skills/*/` against the Agent Skills spec, `claude plugin validate --strict`, identity-field parity between the two manifests, a `SKILL.md` in every skill dir, and no stray manifests. A pass ends with `validate-package: ALL CHECKS PASSED`. It does not connect to the Registry, run skill evals, or test a real client install.

- Bump the `AGENTSKILLS_REF` pin in the script deliberately, as its own change — never silently alongside other edits.
- Before a release, run a live install/discovery trial against a real client (e.g. `codex plugin marketplace add`). This is a release acceptance test, not a per-edit check.

## Layout

- `skills/<name>/SKILL.md` — one Skill per directory; optional `references/` (templates) and `evals/evals.json` (prompt / expected-output cases).
- `references/` — provider-neutral reference docs shared across Skills.
- `plugin.json`, `mcp.json` — portable manifest and MCP config. `.claude-plugin/plugin.json` — Claude manifest.
- `scripts/validate-package.sh` — the only script.

## Architecture / invariants that span files

- **Dual manifests, kept in sync.** Root `plugin.json` is the portable manifest (read by Codex etc.); `.claude-plugin/plugin.json` is what Claude Code reads and is the only place Claude-specific fields (`mcpServers`) may appear. `name`, `version`, `description`, `author`, `keywords` must be identical in both — bump versions in both. Do not add `.codex-plugin/` or any other fallback manifest.
- **MCP declared twice on purpose.** `bouch-registry` is `"type": "http"` in `.claude-plugin/plugin.json` and `"type": "streamable-http"` in root `mcp.json`, same URL; change both together. Skills must never depend on the server being reachable.
- **One canonical copy per Skill**, under `skills/`. Retire any duplicate living elsewhere rather than maintaining two.
- **Skills are triggered procedures, not standing processes.** The frontmatter `description` defines when a Skill fires (some, e.g. `environment-recon`, also have a "When to run this" section); don't turn them into session-start rituals.
- **`/prime` is deliberately not implemented here.** Only the contract (`references/prime-contract.md`) and the authoring checklist (`skills/prime-authoring/`) ship; every consuming project owns its own.
- **Content must stay `PORTABLE AS-IS`:** no provider-specific assumptions, no dependence on any project's local state, no code copied from source workbenches. This package is a distillation; if it disagrees with the underlying project-local evidence, the evidence wins and this package is updated.

## Conventions

- When adding or renaming a Skill or reference, update the layout tree and the "What this is" list in `README.md`; if the change alters the package's scope, update `description`/`keywords` in both manifests.
- Keep Skill bodies imperative and provider-neutral; put long templates in the Skill's own `references/`.

## Contribution workflow

- Default branch is `main`; branch for non-trivial changes and merge via PR.
- Run `scripts/validate-package.sh` before committing; it must end with `ALL CHECKS PASSED`.

## Other files

`HANDOFF.md` is a dated kickoff packet for a past qualification task (an example of the `handoff-authoring` output), not standing project guidance. It references the since-retired `DEVELOPMENT.md`; that content now lives in this file and `README.md`.
