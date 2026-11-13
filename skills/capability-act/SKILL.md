---
name: capability-act
description: Acquire a discovered capability — resolve a Bouch Registry record to concrete install steps, show them, apply on consent, and verify the result. Use when a task needs a capability that discovery surfaced but nothing has installed, when the user asks to install/enable/get a Bouch plugin, MCP server, workbench, or skill, or when a Registry search returns a record that should now be exercised rather than merely pointed at.
---

# Capability act

Discovery answers "does Bouch have X?". This Skill performs the next hop:
**record → installed**. The Registry stays a read-only pointer service; the
acting happens here, locally, on the host, with the user's consent. Do not
turn the Registry into an installer — it stays a phone book; you are the
hands.

## The loop

1. **Resolve.** If `bouch-act` is on PATH or in the bouch-plugins checkout
   (`doctor/bouch-act`), run `bouch-act plan <query-or-record-id>` and use
   its output verbatim. Otherwise resolve by hand: `get_capability` the
   record, note its `type`, `source.repository`/`url`/`ref`, and
   `native.manifest`, then derive the steps from
   `references/harness-install-table.md` for the harnesses present on this
   host. For plugins the **marketplace pin wins** over the record's `ref` —
   the record ref is a citation, the catalogue pin is what installs.
2. **Show the plan.** Present the record id, type, source and ref, the exact
   commands, and every file that will be written, before running anything.
   Flag two states honestly: a record that exists only in the local
   registry checkout (not yet deployed) and anything sourced from outside
   the `dev.bouch` registry.
3. **Consent.** Proceed only on explicit approval. `apply --yes` is
   acceptable for `dev.bouch/*` records once the plan has been shown.
   **External hits never take `--yes`** — they are unvetted; require a
   fresh interactive confirmation each time and say plainly that the item
   is not estate-reviewed.
4. **Apply.** Run `bouch-act apply <id> --harness <h>` (or `all`) — it backs
   up any config file it edits. Without the script, run the commands from
   the table yourself; before editing `mcp_config.json`, `config.toml`, or
   `doctor.json`, copy the file to `<file>.bak` first.
5. **Verify by read-back**, not by the install's own success echo:
   `claude plugin list` / `codex plugin list` / `devin plugins list` for
   plugins, `claude mcp list` or the config file for MCP servers,
   `bouch-act status`, and `bouch-doctor` when a checkout map changed. If
   the runtime can't safely be exercised, say what was and wasn't verified.
6. **Report** what is now exercised (not just installed), the scope it
   landed at, and anything left for the user — especially secret slots to
   fill in `~/.env`.

## Scope rules

- Only `bouch-agent-core` installs user-wide. Domain plugins land at
  `local` scope (Claude `--scope local`; Devin `--local`) — the host
  architecture check fails on user-wide domain plugins.
- Checkouts (workbenches, evidence repos, adapters) clone into the
  checkouts root and get added to `~/.config/bouch/doctor.json` so
  bouch-doctor can verify them. Adapters clone on a tracking branch;
  frozen evidence repos check out the declared ref.
- Records whose source is not published (`source.url` absent) are
  pointer-only — report that instead of fabricating an install route.

## Boundaries

- **Never write to the remote Registry.** Records change through repo PRs
  only; a missing or wrong record is a fix in the `bouch-registry` repo,
  not an API call.
- **Never write secrets.** Name the `~/.env` slot for the user to fill.
- **Never apply unvetted external items.** The fallback search (official
  MCP Registry, GitHub) returns candidates to review, not things to
  install — the user picks, then you run the native command with fresh
  confirmation.
- **A Registry miss is a routing result, not a failure.** Report the
  coverage gap precisely; offer external candidates only as clearly
  labelled unvetted options.

## When the lesson outlives the session

A surprising resolution rule, a stale pin, a broken install path — capture
it in the project's observation log (see the `observation-log` Skill)
rather than re-deriving it next session.
