---
name: capability-act
description: Installs a Bouch capability — resolves a marketplace entry or Bouch catalogue record to install steps, shows them, applies on consent and verifies by read-back. Use when the user asks to install, enable or get a Bouch plugin, MCP server, workbench or skill, or when a task needs a capability that discovery found but nothing has installed.
---

# Capability act

The marketplace and the Bouch catalogue (`registry/entries/` in the `bouch-registry` repo) only point. This Skill installs, locally, with the user's consent. Change catalogue records only through PRs to that repo.

## Steps

1. **Resolve.** If `bouch-act` is on PATH or in the bouch-plugins checkout (`doctor/bouch-act`), run `bouch-act plan <query-or-record-id>` and use its output as-is. Otherwise read the record (`registry/entries/<name>.json` in a local checkout or on GitHub), note `type`, `source.repository`/`url`/`ref` and `native.manifest`, and derive the steps from [references/harness-install-table.md](references/harness-install-table.md) for the harnesses on this host. For plugins, the marketplace pin wins over the record's `ref`.
2. **Show the plan** before running anything: record id, type, source and ref, the exact commands, and every file that will be written. Flag records not yet merged to `main`, and anything from outside `dev.bouch`.
3. **Get consent.** `apply --yes` is acceptable for `dev.bouch/*` records once the plan has been shown. External results never take `--yes`: they are unvetted, so ask fresh each time and say so.
4. **Apply.** Run `bouch-act apply <id> --harness <h>` (or `all`); it backs up config files it edits. Without the script, run the commands from the table yourself, copying `mcp_config.json`, `config.toml` or `doctor.json` to `<file>.bak` before editing.
5. **Verify by read-back**, not the install's success message: `claude plugin list`, `codex plugin list` or `devin plugins list` for plugins; `claude mcp list` or the config file for MCP servers; `bouch-act status`; and `bouch-doctor` if a checkout map changed.
6. **Report** what is now exercised (not just installed), the scope it landed at, and anything left for the user — especially `~/.env` secret slots to fill.

## Scope

- Only `bouch-agent-core` installs user-wide. Domain plugins install at local scope (Claude `--scope local`, Devin `--local`).
- Checkouts (workbenches, evidence repos, adapters) clone into the checkouts root and are added to `~/.config/bouch/doctor.json`. Adapters clone on a tracking branch; frozen evidence repos check out the declared ref.
- A record with no `source.url` is pointer-only. Say so; don't invent an install route.

## Boundaries

- Never write secrets. Name the `~/.env` slot for the user to fill.
- Fallback search results (official MCP Registry, GitHub) are candidates to review, not things to install. The user picks; then run the native command with fresh confirmation.
- A catalogue miss is a result, not a failure. Report the gap; offer external candidates only as labelled, unvetted options.
- Record surprises (a stale pin, a broken install path) in `OBSERVATIONS.md` (`observation-log`).
