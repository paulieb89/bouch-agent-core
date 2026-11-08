# Bouch Cross-Provider Operating Contract

A short, provider-neutral reference for direct native-agent work across
ChatGPT, Codex, Claude Code, native harnesses, and MCP services. It adds no
dispatcher, schema, lifecycle, approval gate, or infrastructure. The user stays
in control.

## Direct native work

- Launch the native agent (Claude Code, Codex, or another) directly in the
  project directory.
- Delegation to another agent or provider is optional; use it when it helps.
- The native agent owns its model loop, tools, permissions, and session state.
- MCP supplies callable tools and resources. It is not automatically an agent
  loop, durable job system, or memory store.

## Native sessions and resume

- Native session or thread IDs identify a conversation; resume with the
  provider's own mechanism using that ID.
- Do not resume an active session concurrently from a second process.
- The provider's native session store is authoritative for transcripts, tool
  history, approvals, and execution evidence. Do not rewrite or reconstruct it.

## Permissions

- Use the provider's native permissions and sandbox as configured.
- Do not bypass them, silently elevate authority, or add a second approval
  system.

## Evidence and verification

- Verify meaningful outcomes and say what was and was not checked.
- Distinguish evidence, inference, and remaining uncertainty.
- Preserve useful evidence and reference native records rather than copying
  them as if they were the transcript.
- Specialist inspectors are optional enrichers, not runtime dependencies.
