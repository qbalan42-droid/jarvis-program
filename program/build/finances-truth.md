# Money truth file

`~/HQ/finances/truth.md`. The one place the real numbers live. Every number carries a source and a date, or the word **unverified**. Never round a guess into a fact; never let a hoped-for number sit next to a verified one without the label.

```markdown
# Money truth · updated YYYY-MM-DD

## Net worth
| Item | Amount | Source | Date | Verified |
|---|---|---|---|---|
| Checking | | bank app screenshot | | yes |
| Savings | | | | |
| Debts (list each) | − | statement | | |
| Other (brokerage, crypto, owed to me) | | | | |
| **Net worth** | | | | |

## Burn (monthly)
| Item | Amount | Source | Notes |
|---|---|---|---|
| Rent / mortgage | | | |
| Food | | | |
| Subscriptions (list each) | | | kill list below |
| Transport | | | |
| Everything else | | | |
| **Total burn** | | | |
Runway at current cash: N months.

## Income streams
| Stream | Last month | Next month (likely) | Verified | Lever |
|---|---|---|---|---|
| | | | | the unit of work that moves it |

## The one number
Label · unit · today · goal · date. Weekly pace needed: (goal − today) ÷ weeks left. Is that pace possible on current levers? Yes / no, and what has to change.

## Cash rules (from the interview)
- No spend over $N without a revenue reason.
- Subscriptions to kill this week: …
- Debts cleared in this order: …
- Collections called, not texted.

## What the agent never does without asking
Spending, buying, messaging anyone, trading, deleting. Written here so it is never forgotten.
```

Daily: the cash number (cash on hand, what is owed) goes on one line in `ledger.csv`: `date,cash,owed,note`. Weekly: the review re-reads this file. Monthly: every unverified number gets verified or stays labelled.
