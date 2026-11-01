# Setup walkthrough

You are a Claude Code agent setting up a new machine for your user. Work through the steps in order, verify each one, and do not skip a verification because a step "looked fine". Assume macOS unless the shell says otherwise; Linux notes are inline.

## Step 0. Prerequisites

Check, and install only what is missing:

```bash
command -v claude || echo "install Claude Code: https://docs.claude.com/en/docs/claude-code/setup"
command -v node && command -v npm || echo "install Node 20+: https://nodejs.org or brew install node"
command -v git || echo "install git"
command -v jq || echo "brew install jq   (Linux: apt install jq)"
command -v uv || echo "optional, for the time MCP server: curl -LsSf https://astral.sh/uv/install.sh | sh"
command -v gh || echo "optional: brew install gh"
```

Then clone this repo somewhere permanent, for example `~/jarvis-program`, and `cd` into it.

## Step 1. Run the installer

```bash
bash install.sh
```

It is idempotent. Run it again after fixing anything. It does, in order:

1. Plugin marketplaces: `anthropics/claude-plugins-official`, `thedotmack/claude-mem`.
2. Plugins: superpowers, frontend-design, firecrawl, claude-mem. (Apollo, Postiz and iMessage are also on the official marketplace; install them only if the user has those accounts.)
3. The design-system library: the `awesome-design` skill plus a clone of `VoltAgent/awesome-design-md` (84 brand DESIGN.md files) into `~/.claude/design-references/`.
4. Skills, from their original repositories, global scope:

   | Skill set | Source | What it adds |
   |---|---|---|
   | Marketing skills (43) | `coreyhaines31/marketingskills` | copywriting, CRO, SEO, ads, emails, social, pricing, offers, launch, cold email, sales enablement, and the rest |
   | Design taste family | `leonxlnx/taste-skill` | anti-slop frontend, minimalist, brutalist, high-end visual, redesign, image-to-code, brandkit, stitch, full-output enforcement |
   | Impeccable | `pbakaus/impeccable` | design audit, polish, critique commands and a detector hook |
   | Web interface guidelines | `vercel-labs/agent-skills` | UI review against Vercel's web interface guidelines |
   | Karpathy guidelines | `multica-ai/andrej-karpathy-skills` | think before coding, simplicity, surgical changes, goal-driven execution |
   | Ponytail | `DietrichGebert/ponytail` | the laziest correct solution, YAGNI ladder, debt and audit passes |
   | Humanizer | `blader/humanizer` | removes AI-writing patterns from text |
   | last30days | `mvanhorn/last30days-skill` | what people actually said about a topic in the last 30 days |
   | Obsidian skills | `kepano/obsidian-skills` | Obsidian markdown, Bases, JSON Canvas |
   | Anthropic document skills | `anthropics/skills` | docx, pptx, xlsx, pdf, skill-creator, mcp-builder |
   | gstack | `garrytan/gstack` | CEO / eng manager / designer / QA / release review roles |
   | Claude video | `bradautomates/claude-video` | watch and summarize video, image and video generation helpers |

5. MCP servers, user scope: playwright, context7, sequential-thinking, time.
6. Global instructions: `claude/CLAUDE.md` into `~/.claude/CLAUDE.md` (appended inside markers if a file already exists).
7. Settings: merges hooks, status line and the safe permission allowlist from `claude/settings.additions.json` into `~/.claude/settings.json`, after backing it up.
8. The HQ: `knowledge/` to `~/HQ/knowledge/`, `tools/` to `~/HQ/tools/`, `program/` to `~/HQ/program/`, and a pointer to all three in `CLAUDE.md`.

## Step 2. Verify

```bash
bash verify.sh
```

Every line must say OK. If a skill is missing, install it by hand with the command printed next to it. If `npx skills` is unavailable, `git clone` the repo and copy or symlink its skill folders into `~/.claude/skills/`.

Then restart Claude Code and confirm, in a fresh session, that the skills appear in the available-skills list and `claude mcp list` shows all four servers connected.

## Step 3. Memory

Your harness gives you a persistent memory directory (the system prompt names it, under `~/.claude/projects/<project>/memory/`). Create it from `claude/memory/`:

1. Copy `claude/memory/MEMORY.md` there as the index.
2. Read `knowledge/memory-system.md` for the file format and the rules: one fact per file, frontmatter with `name`, `description`, `type`; one index line per file; update rather than duplicate; never store secrets or anything a file already records.
3. The interview in Step 5 produces the first memories. Write them in the user's own words.

## Step 4. Read the knowledge base

Read `~/HQ/knowledge/README.md`, then `operating-principles.md`, `coaching-method.md` and `routine-science.md` in full before the interview. Read `research-method.md` before any deep dive. Read the trading documents only when the user's work touches markets. Do not summarize any of them back to the user unprompted; use them.

## Step 5. Run the Program

Read `~/HQ/program/PROGRAM.md` and start Phase 1, the interview. One question at a time. Then build Phase 2 in the order the Program gives, verifying each piece. Report what was built in plain language, with the file paths, and open the island and the day page in the browser.

## Licenses of what you installed

marketingskills: see repo license · taste-skill: see repo · impeccable: Apache 2.0 · agent-skills: see repo · andrej-karpathy-skills: MIT · ponytail: MIT · humanizer: MIT · last30days: see repo · obsidian-skills: see repo · anthropics/skills: per-skill LICENSE.txt · gstack: see repo · claude-video: see repo · awesome-design-md: MIT · superpowers, frontend-design, firecrawl, claude-mem: plugin licenses in their repos.
