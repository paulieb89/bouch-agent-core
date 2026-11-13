# Harness install table

Per-record-type install routes for the three Bouch harnesses, verified
2026-11-12. `bouch-act` generates these commands; when it is absent, derive
them by hand from this table. `$MARKETPLACE` is `bouch-plugins`
(`paulieb89/bouch-plugins`).

## agent-plugin

Plugin name comes from the marketplace catalogues — match the record's id
suffix, title, or `source.repository` (with/without the `bouch-` prefix)
against `.claude-plugin/marketplace.json`. Not every estate plugin is in
the marketplace; when there is no entry, install from the source repo per
its own manifest or record as "no marketplace route".

| Harness | Command |
| --- | --- |
| Claude Code | `claude plugin install <name>@bouch-plugins --scope <s> -y` — `-y` is required non-interactively; `-s` = `user` for bouch-agent-core, `local` for domain plugins. If the marketplace isn't registered: `claude plugin marketplace add paulieb89/bouch-plugins` first. |
| Codex | `codex plugin add <name>@bouch-plugins` — if `bouch-plugins` isn't in `codex plugin marketplace list`, run `codex plugin marketplace add https://github.com/paulieb89/bouch-plugins` first. |
| Devin | `devin plugins install <owner>/<repo>` for external plugins, `devin plugins install paulieb89/bouch-plugins#plugins/<name>` for marketplace-local plugins. Append `--local` for domain plugins (keeps them off the synced personal manifest). |

Notes:

- **The marketplace pin wins.** The catalogue's `ref`/`sha` is what
  installs; a record's `source.ref` is a citation and can lag behind.
- **Devin cannot pin a ref on install** — it tracks HEAD. For a strict
  pin: `git clone` at the tag, then `devin plugins install <path> --local`.
- Devin's CLI mis-reports auth inside IDE-spawned shells. Strip these env
  vars before calling it:
  `env -u ACP_BACKEND -u DEVIN_FD_PATH -u WINDSURF_EXT_HOST_PID -u WINDSURF_CODEIUM_DIR -u WINDSURF_IDE_TYPE -u AI_AGENT devin ...`

## mcp-server

Bouch `mcp-server` records carry no declared remote endpoint — the route
is the record's own contract entrypoint (read it via
`read_capability_entrypoint` or `bouch://source/<id>/<path>`). A record
may be a local stdio server that builds from source — in that case the
"install" is a clone plus its own setup instructions.

For a streamable-http server once an endpoint URL is known:

| Harness | Command |
| --- | --- |
| Claude Code | `claude mcp add --transport http <name> <url>` |
| Codex | `codex mcp add <name> --url <url>` |
| Devin | add a `mcpServers.<name>` entry (`{"url": ..., "transport": "http"}`) to `~/.config/devin/mcp_config.json` — no CLI; back the file up first. |

Adapter checkouts (e.g. `reaper-mcp`) must sit on a branch tracking
origin — `bouch-doctor` fails a detached-HEAD adapter checkout. Clone the
default branch; the record's `ref` is a citation of the adapter state,
not the checkout state.

## reference-workbench / evidence-repository

Pointed at, not installed: `git clone <source.url>` into the checkouts
root (the common parent of the `doctor.json` checkout map), then add the
repo to `~/.config/bouch/doctor.json` `checkouts`. The checkout's own
`.claude/` / `.agents/` content is the capability — nothing else
activates it.

- Evidence repositories with a declared `ref`: clone `--branch <ref>` —
  a detached HEAD at the frozen commit is the correct shape;
  `bouch-doctor` verifies `HEAD == ref`.
- Workbenches: clone the default branch even when the record is frozen —
  the ref is the qualified snapshot, the checkout is for working in.

## agent-skill (standalone)

Fetch the declared `SKILL.md` entrypoint at the record's ref and drop it
into the harness's skill directory:

| Harness | Destination |
| --- | --- |
| Claude Code | `~/.claude/skills/<name>/SKILL.md` (or `.claude/skills/` project-scoped) |
| Codex | `.agents/skills/<name>/` in the target project |
| Devin | `.devin/skills/<name>/` in the target project |

Raw URL form: `https://raw.githubusercontent.com/<owner>/<repo>/<ref>/<path>`.

## observability-tool / remote-agent / routing-pointer

No generic install route. The record's contract entrypoint (its README,
pyproject, or AGENTS.md) owns the install instructions — read it and
follow it rather than improvising.

## Verification

Read back rather than trusting the install echo:

- Plugins: `claude plugin list`, `codex plugin list`, `devin plugins list`
  (match `name@` / `name v` lines, not loose substrings).
- MCP servers: `claude mcp list`, `codex mcp list`, or the config files
  (`~/.codex/config.toml` `[mcp_servers.<name>]`,
  `~/.config/devin/mcp_config.json` `mcpServers.<name>`).
- Estate-wide: `bouch-act status`; after checkout-map changes, `bouch-doctor`.
