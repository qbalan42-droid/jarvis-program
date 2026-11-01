# HQ layout

Everything the agent builds for its person lives under `~/HQ`. One tree, no scattered files.

```
~/HQ/
  profile.json            the interview answers (Phase 1 output)
  knowledge/              the knowledge base (installed from the repo; add method here, never personal data)
  program/                this Program (installed from the repo)
  tools/                  scripts from the repo
  finances/
    truth.md              net worth, burn, streams, the one number, cash rules; every number sourced or marked unverified
    ledger.csv            date, item, amount, source  (append only)
  journey/
    day.json              the day: wake, lights out, blocks, floor, targets, protocol
    rules.json            full-day definition, the floor, the miss rule, if-then plans, phone rules
    day.html              the rendered day page (regenerate whenever day.json changes)
    log/                  one JSON per day: what was logged, the letter
  island/
    index.html            the island board (copied from program/build/island)
    seed.json             the import JSON built from profile.json (keep it; it restores the island)
  bin/
    bell.js               block bells (desktop notification, optional Telegram)
  review/
    TEMPLATE.md           the weekly review
    YYYY-MM-DD.md         one per rest day
  academy/
    curriculum.md         8 weeks, one master each, homework, quiz plan, scores
  reports/                every page the agent writes for the person (dated, HTML)
  research/               deep dives (research_notes/, reports/)
  keys/                   secrets, referenced by path only, never printed; chmod 600
```

Create it with:

```bash
mkdir -p ~/HQ/{finances,journey/log,island,bin,review,academy,reports,research,keys} && chmod 700 ~/HQ/keys
```

Secrets go in `~/HQ/keys/<service>.key`, one per service, mode 600. The agent refers to them by path and never prints their contents.
