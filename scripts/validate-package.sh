#!/usr/bin/env bash
# Cheap, mechanical package-qualification checks for bouch-agent-core.
# Run this on every edit. It does NOT install anything into a real client —
# that's a separate release/acceptance test (see README note at the bottom).
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Pinned to the same commit this package's portability evidence was actually
# checked against (agentskills/agentskills). Bump deliberately, not silently.
AGENTSKILLS_REF="69ef37e9424c0a7ea9dd2293b559e43ec8176379"
AGENT_PLUGINS_SCHEMA_URL="https://agent-plugins.org/schemas/1.0.0/plugin.schema.json"

FAILED=0
fail() { echo "  ✘ $1"; FAILED=1; }
pass() { echo "  ✔ $1"; }

for tool in claude uvx python3; do
  command -v "$tool" >/dev/null 2>&1 || { echo "Required tool not found on PATH: $tool"; exit 2; }
done

echo "== Agent Plugins root schema =="
if [ ! -f plugin.json ]; then
  fail "plugin.json missing at repo root"
else
  if uvx check-jsonschema --schemafile "$AGENT_PLUGINS_SCHEMA_URL" plugin.json >/tmp/validate-package.agent-plugins.log 2>&1; then
    pass "plugin.json conforms to Agent Plugins v1.0.0"
  else
    fail "plugin.json does not conform to Agent Plugins v1.0.0 (see /tmp/validate-package.agent-plugins.log)"
  fi
fi

echo "== Agent Skills validation =="
if [ ! -d skills ]; then
  fail "skills/ directory missing"
else
  for skill_dir in skills/*/; do
    [ -d "$skill_dir" ] || continue
    name="$(basename "$skill_dir")"
    if uvx --from "git+https://github.com/agentskills/agentskills.git@${AGENTSKILLS_REF}#subdirectory=skills-ref" \
        skills-ref validate "$skill_dir" >/tmp/validate-package.skill."$name".log 2>&1; then
      pass "skills/$name"
    else
      fail "skills/$name (see /tmp/validate-package.skill.$name.log)"
    fi
  done
fi

echo "== Claude plugin --strict =="
if claude plugin validate "$REPO_ROOT" --strict >/tmp/validate-package.claude.log 2>&1; then
  pass "claude plugin validate --strict"
else
  fail "claude plugin validate --strict (see /tmp/validate-package.claude.log)"
fi

echo "== Portable <-> Claude identity consistency =="
if [ -f plugin.json ] && [ -f .claude-plugin/plugin.json ]; then
  python3 - <<'PYEOF'
import json, sys
root = json.load(open("plugin.json"))
claude = json.load(open(".claude-plugin/plugin.json"))
mismatches = []
for f in ("name", "version", "description", "author", "keywords"):
    if f in root and f in claude and root[f] != claude[f]:
        mismatches.append(f)
if mismatches:
    print("MISMATCH:", ", ".join(mismatches))
    sys.exit(1)
print("identical: name, version, description, author, keywords (wherever present in both)")
PYEOF
  if [ $? -eq 0 ]; then
    pass "identity fields match between plugin.json and .claude-plugin/plugin.json"
  else
    fail "identity fields diverged between plugin.json and .claude-plugin/plugin.json"
  fi
else
  fail "one of plugin.json / .claude-plugin/plugin.json is missing"
fi

echo "== Clean structural checks =="
[ -f plugin.json ] && pass "root plugin.json present" || fail "root plugin.json missing"
[ -f .claude-plugin/plugin.json ] && pass ".claude-plugin/plugin.json present" || fail ".claude-plugin/plugin.json missing"
if [ -e .codex-plugin ]; then
  fail ".codex-plugin/ present — not needed (Codex reads the portable root manifest directly; see findings/cross-provider/plugin-skill-standards-conformance.md in the enumeration lab)"
else
  pass "no .codex-plugin/ compatibility-fallback clutter"
fi
missing_skill_md=0
for skill_dir in skills/*/; do
  [ -d "$skill_dir" ] || continue
  [ -f "${skill_dir}SKILL.md" ] || { fail "${skill_dir}SKILL.md missing"; missing_skill_md=1; }
done
[ "$missing_skill_md" -eq 0 ] && pass "every skills/*/ has a SKILL.md"
stray=$(find . -path ./.git -prune -o -iname "plugin.json" -print -o -iname "marketplace.json" -print 2>/dev/null \
  | grep -vE '^\./(plugin\.json|\.claude-plugin/plugin\.json)$')
if [ -n "$stray" ]; then
  fail "stray manifest file(s) found outside the two expected locations: $stray"
else
  pass "no stray plugin.json / marketplace.json files"
fi

echo
if [ "$FAILED" -eq 0 ]; then
  echo "validate-package: ALL CHECKS PASSED"
else
  echo "validate-package: FAILED"
fi
exit "$FAILED"

# Deliberately not included: an actual install into a real client (e.g.
# `codex plugin marketplace add` + `codex plugin add`). That's a real
# install/discovery trial against a live client and belongs in a
# release/acceptance test run before a release, not in this cheap,
# mechanical, run-on-every-edit check.
