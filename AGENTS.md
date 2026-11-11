# AGENTS.md

Guidance for coding agents working on this repository.

## What this repo is

`bouch-agent-core` is a portable, provider-neutral Claude/Agent Plugin: Markdown Skills (reasoning procedures) plus reference docs. There is no application code, build step, or test suite. `README.md` ("What this is not") and `DEVELOPMENT.md` are the authoritative contract; read them before structural changes.

## Validate after every edit

```
scripts/validate-package.sh
```

Requires `claude`, `uvx`, `python3` on PATH and network access (fetches schemas and the pinned `agentskills/agentskills` commit). It runs everything in one pass; there is no single-check mode. It checks: root `plugin.json` and `mcp.json` against Agent Plugins v1.0.0 schemas, each `skills/*/` against the Agent Skills spec, `claude plugin validate --strict`, identity-field parity between the two manifests, a `SKILL.md` in every skill dir, and no stray manifests. A pass ends with `validate-package: ALL CHECKS PASSED`. It does not connect to the Registry or test a real client install.

## Architecture / invariants that span files

- **Dual manifests, kept in sync.** Root `plugin.json` is the portable manifest (read by Codex etc.); `.claude-plugin/plugin.json` is what Claude Code reads and is the only place Claude-specific fields (`mcpServers`) may appear. `name`, `version`, `description`, `author`, `keywords` must be identical in both — bump versions in both. Do not add `.codex-plugin/` or any other fallback manifest.
- **MCP declared twice on purpose.** `bouch-registry` is `"type": "http"` in `.claude-plugin/plugin.json` and `"type": "streamable-http"` in root `mcp.json`, same URL; change both together. Skills must never depend on the server being reachable.
- **One canonical copy per Skill**, under `skills/`. Retire any duplicate living elsewhere rather than maintaining two.
- **Skills are triggered procedures, not standing processes.** Each `SKILL.md`'s own "When to run this" section defines the trigger; don't turn them into session-start rituals.
- **`/prime` is deliberately not implemented here.** Only the contract (`references/prime-contract.md`) and the authoring checklist (`skills/prime-authoring/`) ship; every consuming project owns its own.
- **Content must stay `PORTABLE AS-IS`:** no provider-specific assumptions, no dependence on any project's local state, no code copied from source workbenches. This package is a distillation; if it disagrees with the underlying project-local evidence, the evidence wins and this package is updated.
- When adding or renaming a Skill or reference, update the layout trees in both `README.md` and `DEVELOPMENT.md`.

## Other files

`HANDOFF.md` is a dated kickoff packet for a past qualification task (an example of the `handoff-authoring` output), not standing project guidance.
