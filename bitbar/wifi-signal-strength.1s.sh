#!/bin/bash

# <bitbar.title>Wifi Signal Strength</bitbar.title>
# <bitbar.author>Martin</bitbar.author>
# <bitbar.author.github>martinbalfanz</bitbar.author.github>
# <bitbar.desc>Displays current wifi signal strength / RSSI</bitbar.desc>

STRENGTH=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI | sed "s/agrCtlRSSI://")
FONT=('font=Menlo' 'size=8')

if [ "$STRENGTH" -gt -60 ]; then
    echo "${STRENGTH}dBm | color=green"
elif [ "$STRENGTH" -gt -67 ]; then
    echo "${STRENGTH}dBm | color=orange"
else
    echo "${STRENGTH}dBm | color=red"
fi


echo "---"
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | xargs -I % echo % "| $FONT"
