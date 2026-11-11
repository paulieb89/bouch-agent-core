# bouch-agent-core

Portable cross-domain agent-development methodology and reusable Skills.
This package is a distillation of methodology observed converging
independently across several unrelated project harnesses — it is not a
harness, not a framework, and does not take ownership of any project's
local state.

## What this is

- Skills that encode a reasoning *procedure* (when to extend a harness, when
  to run recon, how to author a `/prime`, when to freeze evidence) —
  invoked when a task calls for them, not standing processes.
- A handoff-authoring Skill for durable session transfer, proportional task
  packets, and evidence-bounded continuation.
- An observation-log Skill that stages session lessons and promotes the
  durable ones into project knowledge.
- A project-routing Skill that orients agents across Bouch Core, plugin
  packages, durable knowledge, the Registry, and domain workbenches.
- Reference docs that distil an already-frozen conceptual model, kept
  provider-neutral.

## What this is not

- Not a universal harness or agent framework.
- Not a `/prime` implementation — every project keeps its own, authored
  against `references/prime-contract.md` with help from the
  `prime-authoring` skill.
- Not a candidate/workbench implementation or schema — every domain keeps
  its own candidate representation, fixtures, and acceptance semantics; see
  `references/candidate-evidence-pattern.md` for what is and isn't claimed
  portable there.
- Not a memory store — it documents *where* memory belongs
  (`references/memory-placement.md`) and implements no storage or sync.
- Not a place for project-local, stateful, or credentialed MCP servers,
  settings, or hooks. The one MCP server this package's Claude packaging
  declares (see "Registry connection" below) is a single read-only,
  user-wide pointer to the already-portable Bouch Registry (mirrored in the
  portable `mcp.json`) — it holds no local state, needs no credentials, and
  every Skill here keeps working with it absent. Nothing here is
  project-local.

## Registry connection

The package declares one MCP server, `bouch-registry`, pointing at
`https://registry.bouch.dev/mcp`, in two places that are deliberately kept
separate:

- **Claude** — `.claude-plugin/plugin.json` declares it under `mcpServers`
  as `"type": "http"`. This is the connection Claude Code uses; installing
  this package at user scope (`claude plugin install bouch-agent-core@bouch-plugins
  --scope user`) therefore also connects the Registry in every project, with
  no separate `claude mcp add` step required. It is unchanged by the
  portable config below.
- **Portable (Agent Plugins v1.0.0)** — the root `mcp.json` declares the same
  server as `"type": "streamable-http"`, following the Agent Plugins MCP
  schema (`https://agent-plugins.org/schemas/1.0.0/mcp.schema.json`), for
  non-Claude clients that load the package directly. The root `plugin.json`
  does not reference it explicitly; clients are expected to look for it at
  the package root.

The Registry is a read-only capability-discovery pointer, implemented and
versioned in its own repository — not part of this package, and this
package does not depend on it. Every Skill above works standalone if the
Registry is unreachable or not connected; the Registry only adds the
ability to look up other Bouch capabilities before treating one as absent.

Verification: `scripts/validate-package.sh` checks `mcp.json` against the
published schema and that its URL matches the Claude manifest; it does not
connect to the Registry. An isolated Codex installation loaded the portable
configuration and retrieved a Registry record. A Claude Code session loaded
the plugin connection and retrieved the same record. ChatGPT Work has not
been tested with this connection.

## Layout

```
bouch-agent-core/
├── plugin.json               # portable root manifest (Agent Plugins v1.0.0 spec)
├── mcp.json                  # portable MCP config (Agent Plugins v1.0.0): bouch-registry
├── .claude-plugin/
│   └── plugin.json          # Claude plugin manifest — the only Claude-specific file;
│                             # also declares the bouch-registry MCP connection
├── skills/
│   ├── harness-extension/    # extend the harness only when production proves a real gap
│   ├── environment-recon/    # bounded capability discovery, distinct from /prime
│   ├── prime-authoring/      # contract + checklist for a project's own /prime
│   ├── evidence-freeze/      # preserve verified evidence without rewriting history
│   ├── bouch-project-routing/ # route Core, plugins, knowledge, Registry, and workbenches
│   ├── handoff-authoring/     # author durable handoffs and bounded task packets
│   └── observation-log/        # capture and promote reusable session lessons
├── references/
│   ├── cross-domain-harness-model.md        # the 7-concept model (durable contract, derive-vs-persist, etc.)
│   ├── cross-provider-operating-contract.md # native-agent coordination boundary
│   ├── prime-contract.md                    # frozen semantic contract for a project's own /prime
│   ├── derive-vs-persist.md                 # what to hand-maintain vs. always derive
│   ├── memory-placement.md                  # which layer a fact belongs in (repo/runtime, memory, contract)
│   └── candidate-evidence-pattern.md        # candidate/evidence lineage pattern (no code reproduced)
├── scripts/validate-package.sh  # package qualification checks (see AGENTS.md)
├── AGENTS.md                 # guidance for agents and contributors working on this repo
└── README.md
```

The root `plugin.json` is the portable Agent Plugins manifest, read directly
by non-Claude clients such as Codex; `.claude-plugin/plugin.json` is what
Claude Code reads. The two share identical identity fields — see
[`AGENTS.md`](AGENTS.md) for the invariants and how they are checked.

## Installing

This package needs no settings changes and no hooks, and the Skills work
without any MCP server. Load it directly for a session:

```
claude --plugin-dir /path/to/bouch-agent-core
```

or install it from a marketplace at user scope (see "Registry connection"
above), or copy/symlink it under a project's own plugin/skills directory.
Skills become discoverable via normal progressive disclosure. Only a
user-scope install makes the package — and its Registry connection —
available in every project.

## Portability classification

Every Skill and reference in this package is classified `PORTABLE AS-IS` —
provider-neutral content, with the plugin manifest as the only
Claude-specific packaging. Nothing here needed a provider adapter or turned
out too project-specific to ship; anything that would have needed either was
left out (see the exclusions above) rather than shipped weakened.

If this package's guidance and that evidence ever disagree, the evidence
wins — this package should be updated to match, not treated as
independently authoritative.

## Contributing

See [`AGENTS.md`](AGENTS.md) for the validation workflow, cross-file
invariants, and conventions.

## License

MIT — see [LICENSE](LICENSE).
