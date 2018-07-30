#!/usr/local/bin/node

// <bitbar.title>Wifi Signal Strength</bitbar.title>
// <bitbar.author>Martin</bitbar.author>
// <bitbar.author.github>martinbalfanz</bitbar.author.github>
// <bitbar.desc>Displays current wifi signal strength / RSSI</bitbar.desc>

const execSync = require('child_process').execSync;

let info = execSync("/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I").toString().split("\n");
let data = {};

for (let i = 0; i < info.length - 1; i += 1) {
  let item = info[i];
  data[item.match(/\s*(\w+):/)[1]] = item.match(/\s*\w+:\ (.*$)/)[1];
}

const strength = data.agrCtlRSSI;
const noise = data.agrCtlNoise;
const quality = strength - noise;

if (strength > -60) {
  console.log(`${data.agrCtlRSSI}dBm | color=green`);
} else if (strength > -67) {
  console.log(`${data.agrCtlRSSI}dBm | color=orange`);
} else {
  console.log(`${data.agrCtlRSSI}dBm | color=red`);
}

console.log(`Quality: ${quality}%`);

console.log('---')

for (let i in data) {
  console.log(`${i}: ${data[i]} | font=Menlo`);
}
