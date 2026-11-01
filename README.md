# The Program

One repo that turns a fresh Claude Code install into a full operator agent for one person: the same skill set, plugins, MCP servers, coding discipline, memory system and knowledge base as the original, plus **the Program**: an interview that learns who you are and what you are building, and a build sequence that gives you your own systems. Your own island board, your own locked-in day with bells, your own money truth file, weekly review, academy and coach.

Nothing in here is about anyone else. Your agent builds everything from your answers.

**If you are the person receiving this:** install Claude Code, open it in your home directory, and paste this one line:

> Read `SETUP.md` in https://github.com/qbalan42-droid/jarvis-program and follow it step by step. Run `install.sh`, then `verify.sh`, fix anything that fails. Then read `~/HQ/program/PROGRAM.md` and start Phase 1: interview me.

Your agent will clone the repo, install everything from the original sources, write its own operating instructions, load the knowledge base, then ask you the interview questions one at a time and build your HQ from the answers. Nothing here needs an API key. Nothing here contains anyone's private data.

## What is in here

| Path | What it is |
|---|---|
| `SETUP.md` | The install walkthrough your agent executes, with a verification checklist |
| `install.sh` / `verify.sh` | Idempotent installer and checker: plugins, skills, MCP servers, global instructions, settings, knowledge, the Program |
| `claude/CLAUDE.md` | Global instructions: coding discipline, design defaults, deliverables, and how the agent works with its person (the Operator rules) |
| `claude/settings.additions.json` | Hooks (audit log, desktop notification), status line, safe permission allowlist |
| `claude/memory/` | The persistent memory system: index plus typed memory files, empty until you fill them |
| `program/PROGRAM.md` | The master protocol: install, interview, build, operate |
| `program/interview.md` | The interview: who you are, the island questions, the day, the body, the money, the mind, the people |
| `program/build/` | Templates your agent fills from your answers: the island board, the day file and its bells, the money truth file, the weekly review, the academy, the HQ layout |
| `knowledge/` | Operating principles, coaching method, routine science (166-source evidence base), research method, memory system, trading methodology, video editing |
| `tools/` | Small scripts the knowledge base refers to |

## What is deliberately not in here

API keys, tokens, anyone's personal, health or financial data, client data, paid course material, any commercial indicator source. The knowledge is methodology written from scratch, with public sources cited.

## Licenses

Scripts in `tools/` and `program/build/`: MIT. Documents in `knowledge/` and `program/`: CC BY-NC-SA 4.0. Every third-party skill and plugin installs from its own repository under its own license, listed in `SETUP.md`. The island board (`program/build/island/index.html`) is MIT and uses three.js (MIT) from cdnjs.
