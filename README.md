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
- Not a place for project-local MCP servers, settings, or hooks. Installing
  this package requires none of those.

## Layout

```
bouch-agent-core/
├── .claude-plugin/
│   └── plugin.json          # Claude plugin manifest (the only Claude-specific file)
├── skills/
│   ├── harness-extension/    # extend the harness only when production proves a real gap
│   ├── environment-recon/    # bounded capability discovery, distinct from /prime
│   ├── prime-authoring/      # contract + checklist for a project's own /prime
│   └── evidence-freeze/      # preserve verified evidence without rewriting history
├── references/
│   ├── cross-domain-harness-model.md
│   ├── prime-contract.md
│   ├── derive-vs-persist.md
│   ├── memory-placement.md
│   └── candidate-evidence-pattern.md
└── README.md
```

There is no top-level `plugin.json` outside `.claude-plugin/` — the current
Claude plugin manifest location is `.claude-plugin/plugin.json` only; an
earlier sketch of this package's shape assumed a duplicate root manifest,
which the actual spec does not use.

## Installing

This package needs no marketplace registration, no MCP server, no settings
changes, and no hooks. Load it directly for a session:

```
claude --plugin-dir /path/to/bouch-agent-core
```

or copy/symlink it under a project's own plugin/skills directory per your
Claude Code setup. Skills become discoverable via normal progressive
disclosure; nothing here registers globally on install.

## Portability classification

Every Skill and reference in this package is classified `PORTABLE AS-IS` —
provider-neutral content, with the plugin manifest as the only
Claude-specific packaging. Nothing here needed a provider adapter or turned
out too project-specific to ship; anything that would have needed either was
left out (see the exclusions above) rather than shipped weakened.

## Relationship to the source evidence

This package distils conclusions already reached and evidenced elsewhere;
it does not restate the underlying audits. For the full origin evidence,
see (project-local, not part of this package):

- the cross-domain harness model and Prime contract research behind
  `references/cross-domain-harness-model.md` and `references/prime-contract.md`;
- the qualified candidate-lineage workbench behind
  `references/candidate-evidence-pattern.md`.

If this package's guidance and that evidence ever disagree, the evidence
wins — this package should be updated to match, not treated as
independently authoritative.
