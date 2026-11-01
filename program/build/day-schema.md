# The day file

`~/HQ/journey/day.json` is the single source of truth for the person's day. The day page, the bells and the island's block list all read it, so a change here propagates everywhere. `rules.json` beside it defines what counts as a full day, the floor, the miss rule and the phone rules.

Build it with the 12-step method in `~/HQ/knowledge/routine-science.md`: fixed wake and lights out first, then the two daylight anchors, the caffeine cutoff, meals, the training slot, the heavy work blocks on their best hours, buffers, the wind-down sequence, the floor, the miss rule, the measurements.

## day.json

```
{
  "version": "YYYY-MM-DD-v1",
  "agent": "the agent's name",
  "timezone": "America/Los_Angeles",
  "wake": "HH:MM",
  "lights_out": "HH:MM",
  "blocks": [
    { "t": "HH:MM", "end": "HH:MM", "name": "short name", "kind": "anchor|body|work|team|build|rest",
      "what": "what happens, in two or three sentences, ending with: Never zero: <the smallest version>",
      "num": "the number this block produces, if any" }
  ],
  "rest_day": { "day": 0-6, "wake": "HH:MM", "lights_out": "HH:MM", "note": "", "blocks": [ ... same shape, fewer ... ] },
  "targets": { "<unit>": <per full day>, "<unit>_blocks": { "block name": n }, "notes": "" },
  "interrupt": "the rule when the thing that interrupts by nature fires (a signal, a shift, a child). Numbered steps. Omit if none.",
  "windows": { "hard_stop": "HH:MM", "note": "when outbound work stops for the day" },
  "overrides": { "friday": { "HH:MM": { "name": "", "what": "" } } },
  "protocol": {
    "physique":     { "target": "", "now": "", "phase1": "", "phase2": "", "honest": "the realistic rate and what is unrealistic" },
    "meals":        [ { "t": "HH:MM", "name": "", "kcal": 0, "protein": 0, "what": "" } ],
    "hydration":    [ [ "when", "how much" ] ],
    "showers":      [ [ "HH:MM", "cold|warm|hot", "why" ] ],
    "mobility":     [ [ "HH:MM", "minutes", "what" ] ],
    "lift":         { "rules": "", "days": [ [ "Mon", "session", "exercises and sets" ] ], "weekly_sets": "" },
    "cardio":       [ [ "when", "what" ] ],
    "measurements": [ [ "when", "measure" ] ]
  },
  "evidence_note": "which tiers the main choices rest on, and the two or three places the person chose against the evidence"
}
```

Rules:
- Blocks do not overlap and leave a 10 to 15 minute buffer between any two heavy blocks.
- Every block's `what` ends with a `Never zero:` line. The page splits it out and the bells read it.
- Time in bed is at least 7.5 hours unless the person chose otherwise, in which case say so in `evidence_note`.
- Caffeine cutoff is 8 to 9 hours before lights out. Water stops about an hour before.
- `kind` drives colour on the page: anchor (faith, stillness, reading), body, work (the money unit), team, build, rest.
- The rest day is real: fewer blocks, a later wake, no money unit unless they insist.

## rules.json

```
{
  "full_day": { "<unit>": n, "lights_out": "HH:MM", "reading_min": n, "practice_min": n, "protein_g": n, "steps": n, "audio_min": n },
  "floor": [ "three to five never-zero lines, each checkable yes/no", "Lights out by HH:MM (full day HH:MM)" ],
  "miss_rule": "what happens the morning after a missed floor day, paid first thing",
  "if_then": [ "When X happens, I do Y within N seconds." ],
  "phone": "what rings through during work blocks, what does not, where the phone sleeps",
  "letters": { "F": "full day: every full_day target met", "L": "floor kept, full day missed", "X": "floor missed", "S": "rest day kept as rest" },
  "measure": { "daily": [ "" ], "weekly": [ "" ], "decisions": [ "the numbers that trigger a change to this file" ] }
}
```

Generate `day.html` from `day.json` every time it changes: a dark page with a numbers row, the timeline (time, name, what, never-zero line, number), the rest day, the protocol tables, the floor. Phone width first, no horizontal scroll. Open it in the browser when done.
