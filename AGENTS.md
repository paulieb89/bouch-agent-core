# AGENTS.md

`bouch-agent-core` is a portable Agent Plugin: Markdown Skills plus manifests. No application code, build step or dependencies.

## Commands

```
scripts/validate-package.sh   # run after every edit; must end with ALL CHECKS PASSED
claude --plugin-dir .         # load into a local Claude Code session
```

`validate-package.sh` needs `claude`, `uvx`, `python3` and network access. It checks the manifests against their schemas, each skill against the Agent Skills spec (pinned `AGENTSKILLS_REF`), `claude plugin validate --strict`, and manifest parity. It doesn't run evals or test a real client install — do a live install trial before a release.

## Rules

- **Two manifests, kept in sync.** `name`, `version`, `description`, `author` and `keywords` must match in `plugin.json` and `.claude-plugin/plugin.json`; bump versions in both. No `.codex-plugin/` or other fallback manifest.
- **One copy per Skill**, under `skills/`. Shared material lives in one skill and is referenced by name from others, not duplicated.
- **Skills stay portable:** no machine paths, provider assumptions or project state.
- **Write for an agent:** imperative instructions only. Leave out what models already do by default, background, provenance and "what this is not" sections. Keep each `SKILL.md` well under 500 lines and references one level deep.
- Bump `AGENTSKILLS_REF` deliberately, in its own change.
- When adding or renaming a Skill, update the README table and, if scope changes, the manifests' `description`/`keywords`. Update the `bouch-agent-core` catalogue record's entrypoints in the same release.

## Workflow

Branch from `main`, run the validator, merge via PR. After a release, bump the pin in `paulieb89/bouch-plugins`.
