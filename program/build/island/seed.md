# Seeding the island

The island (`index.html`) is one file. It stores its state in the browser's localStorage and can import a full state through **Your data → Restore from the text above**. Build that state from the interview instead of making the person type it twice.

1. `cp ~/HQ/program/build/island/index.html ~/HQ/island/index.html`
2. `python3 ~/HQ/program/build/island/seed.py ~/HQ/profile.json > ~/HQ/island/seed.json`
3. `open ~/HQ/island/index.html`, tap **Your data**, paste the contents of `seed.json`, tap **Restore**.
4. Verify: the title shows their island's name, the day counter says Day 1 on `runStart`, the buildings match their areas, the floor sheet lists their never-zero lines, and the blocks bar shows their blocks.

State fields (`v: 1`): `profile` (island, mission, source, runDays, runStart, wake, lights, restDay 0-6 or -1, restNote, identity, missRule, teacher), `number` (label, unit, start, goal, by), `areas[]` (k, name, label, type check|count, target, style chapel|gym|office|bank|library|studio|house|harbour), `floor[]` (k, label), `blocks[]` (t, end, name), `cuts[3]`, `people[2]`, `rewards{}`, `ledger{}`, `hist[]`, `seenTier`.

How it grows: buildings level at 3, 7, 14, 30 and 60 kept days per area. The island itself moves through Castaway → Beachcomber → Islander → Homesteader → Harbourmaster → Arrived as the one number moves from start to goal. Ten milestones sit between start and goal; the person writes the reward for each in the Milestones sheet. Every kept day lays a stone; the letters F, L, X, S are the daily grade.

Rest day is the island's rest day too. On it the island asks nothing but the review.

To change the questions, tiers or building styles, edit `Q`, `TIERS` and `STYLE` in `index.html`. Keep it one file.
