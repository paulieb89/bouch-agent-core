# bouch-agent-core

Portable Skills for working across Bouch projects: routing work to the right place, closing capability gaps, keeping evidence trustworthy, and carrying state and lessons between sessions. Provider-neutral Markdown with thin Claude packaging; it holds no project state.

## Skills

| Skill | Use when |
| --- | --- |
| `bouch-project-routing` | Starting unfamiliar Bouch work; deciding where a fact, lesson or piece of evidence belongs |
| `capability-gap` | The environment is unfamiliar or has drifted, or work is blocked by a missing capability |
| `evidence-freeze` | A verified result is worth preserving and pointing back to |
| `prime-authoring` | Writing or reviewing a project's own `/prime` |
| `handoff-authoring` | Work moves to another session, agent or provider |
| `observation-log` | A lesson should outlive the session, or the log needs review |
| `capability-act` | Installing a Bouch plugin, MCP server, workbench or skill |

Each project keeps its own `/prime`, workbench schema and state; this package only describes the contracts they follow.

## Install

```
claude plugin marketplace add paulieb89/bouch-plugins
claude plugin install bouch-agent-core@bouch-plugins --scope user
```

Codex: `codex plugin marketplace add paulieb89/bouch-plugins`, then `codex plugin add bouch-agent-core@bouch-plugins`. For local testing: `claude --plugin-dir /path/to/bouch-agent-core`.

## Layout

```
plugin.json               portable manifest (Agent Plugins v1.0.0)
.claude-plugin/plugin.json  Claude manifest
skills/<name>/SKILL.md    one Skill per directory, with optional references/ and evals/
scripts/validate-package.sh
```

## Contributing

See [AGENTS.md](AGENTS.md).

## License

MIT — see [LICENSE](LICENSE).
