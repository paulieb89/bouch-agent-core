# Bouch Cross-Provider Operating Contract

This is the shared operating contract for Bouch coordination across ChatGPT,
Codex, Claude Code, native harnesses, and MCP services.

## Roles

- The coordinator chooses the task, project, provider, permission mode, and
  optional native session.
- The native agent owns its model loop, tools, permissions, and native session
  state.
- A harness supplies runtime composition, tools, context, persistence, and
  verification when a native agent is not being used directly.
- MCP supplies callable tools and resources. It is not automatically an agent
  loop, durable job system, or memory store.
- An evidence inspector reads native traces and produces references and
  observations. It does not become the source of truth for the session.

## Dispatch and observation contract

A dispatch has a provider (`claude` or `codex`), absolute project directory,
task text, explicit permission mode, and optional native session ID. A local
coordinator may return before the native process finishes. The coordinator
persists a run ID and exposes polling-oriented state:

```json
{
  "run_id": "local-run-id",
  "provider": "claude",
  "project": "/absolute/project/path",
  "session_id": "native-session-id-or-null",
  "status": "running|completed|failed|interrupted|unknown",
  "text": "final native-agent text-or-null",
  "error": null,
  "activity": [],
  "changed_files": [],
  "evidence": [],
  "artifacts": [],
  "continuation_possible": true
}
```

`get_run` and equivalent observation operations may expose concise activity and
provider-specific evidence references. They must not imply that a copied raw
output file is the native transcript.

Provider/session identity is explicit. CLI resume requires a native session or
thread ID. An active native session must not be resumed concurrently by a
second Runner operation. A new run may be created for a continuation, but the
native ID remains the authority for which conversation is continued.

The four lifetimes are distinct:

1. MCP client connection.
2. Coordinator server process.
3. Native provider process.
4. Native provider session persistence.

Client disconnection does not itself cancel a native process. If the
coordinator server restarts without safely reattaching to an active process,
the run is reported as `unknown`, not falsely as completed or still observed.
If the native session ID is known, explicit native resumption remains the
recovery path.

## Authority and evidence

The provider's native session store remains authoritative for transcripts, tool
history, approvals, and detailed execution evidence. A coordinator may retain
raw command output, compact event summaries, changed-file observations, and
references to native records. It must not silently replace, rewrite, or
reconstruct the native session store.

`sessinspect` and other specialist inspectors are optional evidence enrichers,
not mandatory runtime dependencies.

## Permissions

Permission modes are explicit and provider-native: `native`, `read_only`, or
`workspace_write`, where supported by the adapter and installed provider. An
unsupported mode must fail clearly. The coordinator does not create a second
approval system, bypass native permissions, or silently elevate authority.

## Review and improvement

Review is an explicit, read-only operation outside ordinary dispatch and
continuation. It may propose one durable improvement linked to concrete
runtime evidence and an explicit target: Bouch Core, a project contract, a
Skill, or another declared target.

Candidates are suggestions, not instructions. Their lifecycle is:

```text
proposed → accepted/rejected → explicitly promoted
```

Human acceptance is required. Promotion creates an advisory packet or an
explicitly authorised implementation task. No reviewer, hook, MCP tool, or
runner may silently rewrite global instructions, a project contract, or a
Skill.

## Boundaries

Do not duplicate provider-specific permission systems in the coordinator. Do
not use the Registry as a mutable run queue. Do not turn Bouch Core into a
provider-specific runtime merely to dispatch a native session. Prefer the
smallest adapter that makes the native capability observable and callable.
