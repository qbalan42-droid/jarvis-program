#!/usr/bin/env bash
# Program installer: skills, plugins, MCP servers, global instructions, knowledge, the Program. Idempotent: safe to run again.
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
HQ="$HOME/HQ"; KB="$HQ/knowledge"
ok()   { printf '  \033[32mOK\033[0m   %s\n' "$*"; }
warn() { printf '  \033[33mWARN\033[0m %s\n' "$*"; }
step() { printf '\n== %s ==\n' "$*"; }

step "0. prerequisites"
for c in claude node npm git jq; do command -v "$c" >/dev/null 2>&1 && ok "$c" || warn "$c missing (see SETUP.md step 0)"; done
command -v uv >/dev/null 2>&1 && ok "uv" || warn "uv missing: the time MCP server will be skipped"
mkdir -p "$CLAUDE_DIR/skills" "$KB" "$HQ/tools" "$HQ/program" "$CLAUDE_DIR/design-references"

step "1. plugin marketplaces"
for m in anthropics/claude-plugins-official thedotmack/claude-mem; do
  claude plugin marketplace add "$m" >/dev/null 2>&1 && ok "marketplace $m" || warn "marketplace $m (may already exist)"
done

step "2. plugins"
for p in superpowers@claude-plugins-official frontend-design@claude-plugins-official firecrawl@claude-plugins-official claude-mem@thedotmack; do
  claude plugin install "$p" >/dev/null 2>&1 && ok "plugin $p" || warn "plugin $p (already installed, or install by hand: claude plugin install $p)"
done
echo "  note: apollo, postiz and imessage plugins exist on claude-plugins-official; install only with those accounts."

step "2b. design-system library (awesome-design skill + the DESIGN.md repo it reads)"
rm -rf "$CLAUDE_DIR/skills/awesome-design"; cp -R "$HERE/claude/skills/awesome-design" "$CLAUDE_DIR/skills/awesome-design" && ok "skill awesome-design"
if [ -d "$CLAUDE_DIR/design-references/awesome-design-md/.git" ]; then git -C "$CLAUDE_DIR/design-references/awesome-design-md" pull -q >/dev/null 2>&1 && ok "awesome-design-md updated" || warn "awesome-design-md pull failed (offline?)"
else git clone -q --depth 1 https://github.com/VoltAgent/awesome-design-md "$CLAUDE_DIR/design-references/awesome-design-md" >/dev/null 2>&1 && ok "awesome-design-md cloned" || warn "awesome-design-md clone failed; the skill will have nothing to read"; fi

step "3. skills (global, from original repositories)"
SKILL_REPOS="coreyhaines31/marketingskills leonxlnx/taste-skill pbakaus/impeccable multica-ai/andrej-karpathy-skills DietrichGebert/ponytail blader/humanizer mvanhorn/last30days-skill kepano/obsidian-skills anthropics/skills garrytan/gstack bradautomates/claude-video vercel-labs/agent-skills"
for r in $SKILL_REPOS; do
  if npx -y skills add "$r" --global --yes --agent claude-code >/dev/null 2>&1; then ok "skills from $r"
  else
    # fallback: clone and link every folder that carries a SKILL.md
    tmp="$(mktemp -d)"; if git clone --depth 1 "https://github.com/$r" "$tmp/repo" >/dev/null 2>&1; then
      n=0; while IFS= read -r sk; do d="$(dirname "$sk")"; name="$(basename "$d")"; [ "$name" = "repo" ] && name="$(basename "$r")"
        rm -rf "$CLAUDE_DIR/skills/$name"; cp -R "$d" "$CLAUDE_DIR/skills/$name"; n=$((n+1)); done < <(find "$tmp/repo" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/.git/*')
      ok "skills from $r (cloned, $n skill folders copied)"
    else warn "skills from $r: npx skills failed and clone failed; install by hand"; fi
    rm -rf "$tmp"
  fi
done

step "4. MCP servers (user scope)"
claude mcp add -s user playwright -- npx -y @playwright/mcp@latest --browser chromium >/dev/null 2>&1 && ok "playwright" || warn "playwright (exists?)"
claude mcp add -s user context7 -- npx -y @upstash/context7-mcp >/dev/null 2>&1 && ok "context7" || warn "context7 (exists?)"
claude mcp add -s user sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking >/dev/null 2>&1 && ok "sequential-thinking" || warn "sequential-thinking (exists?)"
if command -v uv >/dev/null 2>&1; then claude mcp add -s user time -- uvx mcp-server-time >/dev/null 2>&1 && ok "time" || warn "time (exists?)"; fi

step "5. global instructions"
MARK_A="<!-- program:start -->"; MARK_B="<!-- program:end -->"
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then cp "$HERE/claude/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"; ok "wrote ~/.claude/CLAUDE.md"
elif grep -q "$MARK_A" "$CLAUDE_DIR/CLAUDE.md"; then ok "~/.claude/CLAUDE.md already carries the program block"
else { printf '\n%s\n' "$MARK_A"; cat "$HERE/claude/CLAUDE.md"; printf '%s\n' "$MARK_B"; } >> "$CLAUDE_DIR/CLAUDE.md"; ok "appended the program block to ~/.claude/CLAUDE.md"; fi

step "6. settings (hooks, status line, safe allowlist)"
S="$CLAUDE_DIR/settings.json"; [ -f "$S" ] || echo '{}' > "$S"
cp "$S" "$S.bak.$(date +%Y%m%d%H%M%S)"
if command -v jq >/dev/null 2>&1; then
  jq -s '.[0] as $cur | .[1] as $add
    | $cur
    | .hooks = (($cur.hooks // {}) * $add.hooks)
    | .permissions.allow = ((($cur.permissions.allow // []) + $add.permissions.allow) | unique)
    | .statusLine = ($cur.statusLine // $add.statusLine)' "$S" "$HERE/claude/settings.additions.json" > "$S.new" && mv "$S.new" "$S" && ok "merged settings (backup kept)"
  command -v ccusage >/dev/null 2>&1 || npm i -g ccusage >/dev/null 2>&1 && ok "ccusage status line" || warn "ccusage not installed; status line will be blank until: npm i -g ccusage"
else warn "jq missing: merge claude/settings.additions.json into ~/.claude/settings.json by hand"; fi

step "7. knowledge base, tools, the Program"
cp -R "$HERE/knowledge/." "$KB/" && ok "knowledge -> $KB"
cp -R "$HERE/tools/." "$HQ/tools/" && ok "tools -> ~/HQ/tools"
cp -R "$HERE/program/." "$HQ/program/" && ok "program -> ~/HQ/program"
grep -q "HQ/knowledge" "$CLAUDE_DIR/CLAUDE.md" || printf '\n## Knowledge base and the Program\nRead ~/HQ/knowledge/README.md at the start of any task it covers (coaching, routine design, research, trading, marketing deliverables, video). Memory format: ~/HQ/knowledge/memory-system.md. The Program that interviews the user and builds their systems: ~/HQ/program/PROGRAM.md. Run it in the first session.\n' >> "$CLAUDE_DIR/CLAUDE.md"

printf '\nDone. Now run: bash verify.sh\n'
