# The interview

Ask one question at a time, in this order. Short answers are the right answers: a sentence or a number each. The rule for every answer: it has to hold on their worst day, not their best one. Push back once when an answer fails that rule, then accept the revision.

Open with this, in your own words: *"I am going to ask you about forty short questions, one at a time. They build your systems: your day, your island, your money file, your coach. Answer in a sentence or a number. If you don't know a number, say so and we mark it unverified."*

## Part A. You and your agent (4)

1. What do you want to call me? (This becomes the agent's name in every page and message.)
2. Who are you, in three sentences? Age range, where you live (city is enough), what you do for money today.
3. What is the mission, in one sentence? What is all of this for?
4. What do you return to every morning: your Source? (Faith, a verse, a practice, a person, a principle. Their words, verbatim. If God, God stays at the center of the day you build.)

## Part B. The run and the island (12)

These are the island's own questions; the board asks them too, but you ask them here first so you can push back.

5. Name the island. One sentence on what the run is for.
6. How many days is the run (90 is the default), and what date is day 1?
7. Wake time and lights-out time on a normal day.
8. The one number that proves the run worked: label, unit, where it is today, where it must be at the end.
9. Up to eight life areas, each with a daily bar a yes/no or a count can answer (faith, body, work, money, mind, craft, home, people, or their own).
10. The floor: three to five never-zero minimums. Small enough to do sick, tired or travelling.
11. Work blocks: up to six, each with a start, an end and a name. (You will refine these in Part D.)
12. The rest day, and what it is for so it stays a rest and not a drift.
13. Two protected people and the fixed weekly touch for each.
14. Three cuts: three things that are out for the length of the run.
15. The miss rule: what happens the morning after a missed floor day. A cost paid first thing, not a punishment that breaks them.
16. The identity sentence (who they are during this run), and one teacher a week if they want one.

## Part C. Money (7)

Mark every number they cannot verify right now as **unverified**. Never round a guess into a fact.

17. Net worth today: cash, debts, anything else that matters. Source for each (bank app, statement, memory).
18. Monthly burn: rent, the rest. Source.
19. Every income stream: what it is, what it paid last month, what it is likely to pay next month.
20. The unit of work that makes money (calls, emails, posts, sessions, shifts, clients served). How many a day now? How many on a full day?
21. The money target at the end of the run and the date. Then: what would have to be true weekly for that to happen? (Do the arithmetic with them. If the weekly number is impossible, say so now.)
22. The cash rules they want you to hold them to: a spend ceiling without a revenue reason, subscriptions to kill, debts to clear first.
23. What must you never do with their money or on their behalf without asking? (Spending, messaging anyone, trading, deleting.)

## Part D. The day and the work (6)

24. When are their best working hours, honestly? When are the dead hours?
25. Anything that interrupts by nature (a signal, a shift, a child, a class)? What is the rule when it fires?
26. Who else is on the team, and what do they need from them daily? (A huddle? A number? Nothing?)
27. What is the one "build" that moves next month's money, as opposed to today's? (A system, a list, an offer, a page.) This becomes a daily build block.
28. Phone and notifications: what rings through during work blocks and what does not?
29. Where will they log the day: the island, a notebook, a sheet? (Default: the island.)

## Part E. The body (6)

Routine-science rules apply. Say the evidence tier when you push back.

30. Height, weight today, where they want the body to be and by when. (If the rate is faster than about half a pound a week of lean gain or one to two pounds a week of fat loss, say so.)
31. Training now: what, how often, how long. Injuries.
32. Food now: what a normal day looks like. What they will not eat. Budget per day.
33. Sleep now: usual bedtime, usual wake, how they feel at 3 pm.
34. Caffeine, alcohol, nicotine, anything prescribed. (Prescribed: note it, build around it, give no medical advice; recommend monitoring only.)
35. Any health monitoring they have: blood pressure cuff, scale, labs in the last year.

## Part F. Mind, faith, people (5)

36. What are they reading, and how many minutes a day will they protect for it?
37. Teachers: up to eight people or books they want to master over the run. (This seeds the academy; skip it if they name none.)
38. Faith or stillness practice, in minutes, and where it sits in the day. Their words.
39. Podcasts, lectures, or courses for the walking hours: how many minutes of movement a day can carry audio?
40. Who do they report to each week besides you? (A partner, a parent, a friend, a group.) What do they want that report to contain?

## Closing (2)

41. What has broken every past attempt at this? (The honest answer sets the floor and the miss rule.)
42. Anything they want you to never bring up, and anything they want you to bring up every single day?

## Output: `~/HQ/profile.json`

```json
{
  "agent": "name",
  "person": { "summary": "", "city": "", "work": "" },
  "mission": "", "source": "",
  "island": { "name": "", "runDays": 90, "runStart": "YYYY-MM-DD", "wake": "HH:MM", "lights": "HH:MM",
              "number": { "label": "", "unit": "", "start": 0, "goal": 0 },
              "areas": [ { "k": "", "name": "", "label": "", "type": "check|count", "target": 1, "style": "chapel|gym|office|bank|library|studio|house|harbour" } ],
              "floor": [ "" ], "blocks": [ { "t": "HH:MM", "end": "HH:MM", "name": "" } ],
              "restDay": 0, "restNote": "", "people": [ "", "" ], "cuts": [ "", "", "" ],
              "missRule": "", "identity": "", "teacher": "" },
  "money": { "netWorth": { "value": 0, "source": "", "verified": false }, "burn": { "value": 0, "source": "", "verified": false },
             "streams": [ { "name": "", "lastMonth": 0, "nextMonth": 0, "verified": false } ],
             "unit": { "name": "", "nowPerDay": 0, "fullDay": 0 }, "target": { "value": 0, "by": "YYYY-MM-DD", "weeklyNeeded": 0 },
             "rules": [ "" ], "neverWithoutAsking": [ "" ] },
  "day": { "bestHours": "", "deadHours": "", "interrupt": { "what": "", "rule": "" }, "team": "", "build": "", "phone": "", "log": "island" },
  "body": { "heightCm": 0, "weightKg": 0, "goal": "", "by": "", "training": "", "injuries": "", "food": "", "budgetPerDay": 0,
            "sleep": { "bed": "", "wake": "", "pm": "" }, "substances": "", "prescribed": "", "monitoring": "" },
  "mind": { "reading": "", "readMin": 0, "teachers": [ "" ], "practice": { "what": "", "min": 0, "when": "" }, "audioMin": 0, "reportsTo": "" },
  "closing": { "whatBroke": "", "neverRaise": "", "raiseDaily": "" }
}
```

Fields they could not answer stay empty strings or zero with `"verified": false`. Never fill a field with a guess.
