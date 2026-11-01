#!/usr/bin/env python3
"""seed.py - build the island's import JSON from ~/HQ/profile.json.
   python3 seed.py ~/HQ/profile.json > ~/HQ/island/seed.json
Then open ~/HQ/island/index.html, tap "Your data", paste the JSON into the box and tap "Restore from the text above".
The island stores everything in that browser's localStorage; keep seed.json so it can be restored."""
import json, sys, datetime
p = json.load(open(sys.argv[1] if len(sys.argv) > 1 else sys.argv[0].replace('seed.py', '../../../profile.json')))
isl = p.get('island', {})
STYLES = ['chapel', 'gym', 'office', 'bank', 'library', 'studio', 'house', 'harbour']
areas = []
for i, a in enumerate((isl.get('areas') or [])[:8]):
    k = a.get('k') or a.get('name', 'area%d' % i).lower().replace(' ', '')[:12]
    areas.append({'k': k, 'name': a.get('name', k.title()), 'label': a.get('label', ''), 'type': 'count' if a.get('type') == 'count' else 'check',
                  'target': a.get('target', 1) or 1, 'style': a.get('style') if a.get('style') in STYLES else STYLES[i % len(STYLES)]})
floor = [{'k': 'f%d' % (i + 1), 'label': f} for i, f in enumerate((isl.get('floor') or [])[:5]) if f]
blocks = [{'t': b.get('t', ''), 'end': b.get('end', ''), 'name': b.get('name', 'Block %d' % (i + 1))} for i, b in enumerate((isl.get('blocks') or [])[:6])]
num = isl.get('number') or {}
state = {
    'v': 1, 'setup': True, 'created': datetime.date.today().isoformat(),
    'profile': {'island': isl.get('name') or 'My Island', 'mission': p.get('mission', ''), 'source': p.get('source', ''),
                'runDays': int(isl.get('runDays') or 90), 'runStart': isl.get('runStart') or datetime.date.today().isoformat(),
                'wake': isl.get('wake') or '06:00', 'lights': isl.get('lights') or '22:00',
                'restDay': isl.get('restDay', 0) if isl.get('restDay', 0) != '' else -1, 'restNote': isl.get('restNote', ''),
                'identity': isl.get('identity', ''), 'missRule': isl.get('missRule', ''), 'teacher': isl.get('teacher', '')},
    'number': {'label': num.get('label') or 'The number', 'unit': num.get('unit', ''), 'start': num.get('start', 0) or 0, 'goal': num.get('goal', 0) or 0, 'by': num.get('by', '')},
    'areas': areas, 'floor': floor, 'blocks': blocks,
    'cuts': ((isl.get('cuts') or []) + ['', '', ''])[:3], 'people': ((isl.get('people') or []) + ['', ''])[:2],
    'rewards': {}, 'ledger': {}, 'hist': [], 'seenTier': -1,
}
if not areas or not floor or not blocks: sys.stderr.write('warning: areas, floor or blocks empty; the island will use its defaults for those\n')
print(json.dumps(state, indent=1))
