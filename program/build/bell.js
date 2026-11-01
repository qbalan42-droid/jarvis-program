#!/usr/bin/env node
// bell.js - block bells for ~/HQ/journey/day.json.
// Every 20 s: at a block's start time, a desktop notification with the block name and its never-zero line.
// At lights out minus 30 min, a wind-down bell. On the rest day it reads rest_day.blocks instead.
// Optional Telegram: create ~/HQ/keys/telegram.key with two lines, the bot token then the chat id. The file is read by path and never printed.
//   node bell.js            run forever (launchd: build/com.hq.bell.plist)
//   node bell.js test       fire one notification now and exit
const fs = require('fs'), { execFile } = require('child_process'), https = require('https');
const HQ = process.env.HOME + '/HQ', DAY = HQ + '/journey/day.json', KEY = HQ + '/keys/telegram.key', LOG = HQ + '/journey/log/bell.log';
const log = (s) => { const l = new Date().toISOString() + ' ' + s; console.log(l); try { fs.appendFileSync(LOG, l + '\n'); } catch (e) {} };
function day() { try { return JSON.parse(fs.readFileSync(DAY, 'utf8')); } catch (e) { return null; } }
function notify(title, body) {
  execFile('osascript', ['-e', `display notification ${JSON.stringify(body)} with title ${JSON.stringify(title)} sound name "Glass"`], () => {});
  let tg = null; try { const [tok, chat] = fs.readFileSync(KEY, 'utf8').split('\n').map(s => s.trim()); if (tok && chat) tg = { tok, chat }; } catch (e) {}
  if (tg) {
    const data = JSON.stringify({ chat_id: tg.chat, text: title + '\n' + body });
    const req = https.request({ host: 'api.telegram.org', path: '/bot' + tg.tok + '/sendMessage', method: 'POST', headers: { 'Content-Type': 'application/json', 'Content-Length': Buffer.byteLength(data) } }, (r) => r.resume());
    req.on('error', (e) => log('telegram ' + e.message)); req.end(data);
  }
}
function neverZero(what) { const m = /Never zero: (.*)$/.exec(what || ''); return m ? m[1].trim() : ''; }
function hm(d = new Date()) { return String(d.getHours()).padStart(2, '0') + ':' + String(d.getMinutes()).padStart(2, '0'); }
function minus(t, mins) { const [h, m] = t.split(':').map(Number); const x = ((h * 60 + m - mins) + 1440) % 1440; return String(Math.floor(x / 60)).padStart(2, '0') + ':' + String(x % 60).padStart(2, '0'); }
if (process.argv[2] === 'test') { const d = day(); const b = d && d.blocks && d.blocks[0]; notify((d && d.agent || 'Agent') + ' · test bell', b ? b.name + ' · ' + neverZero(b.what) : 'day.json not found at ' + DAY); log('test bell fired'); process.exit(0); }
let sent = new Set(), sentDay = '';
log('bell start, reading ' + DAY);
setInterval(() => {
  const d = day(); if (!d) return;
  const now = new Date(), today = now.toDateString(); if (today !== sentDay) { sent = new Set(); sentDay = today; }
  const rest = d.rest_day && Number(d.rest_day.day) === now.getDay();
  const blocks = rest && d.rest_day.blocks ? d.rest_day.blocks : (d.blocks || []);
  const lights = rest && d.rest_day.lights_out ? d.rest_day.lights_out : d.lights_out;
  const t = hm(now), name = d.agent || 'Agent';
  for (const b of blocks) { if (b.t === t && !sent.has('b' + b.t)) { sent.add('b' + b.t); notify(name + ' · ' + b.t + ' · ' + b.name, neverZero(b.what) || (b.what || '').slice(0, 120)); log('bell ' + b.t + ' ' + b.name); } }
  if (lights && minus(lights, 30) === t && !sent.has('wind')) { sent.add('wind'); notify(name + ' · wind-down', 'Lights out at ' + lights + '. Screens off, lamps only, tomorrow\'s card.'); log('wind-down bell'); }
}, 20000);
