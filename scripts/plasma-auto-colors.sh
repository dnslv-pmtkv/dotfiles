#!/bin/bash
export LC_ALL=en_US.UTF-8

# Sofia, Bulgaria coordinates
LAT="42.6977N"
LON="23.3219E"

MIN=$(date +%M)
NOW=$((HOUR*60 + MIN))

# Output format: 07:10, 18:10
TIMES=$(sunwait list 1 civil $LAT $LON)

SUNRISE=$(echo $TIMES | cut -d',' -f1)
SUNSET=$(echo $TIMES | cut -d',' -f2 | xargs)

# Convert HH:MM to minutes
SR_HOUR=${SUNRISE%%:*}
SR_MIN=${SUNRISE##*:}
SUNRISE_MIN=$((SR_HOUR*60 + SR_MIN))

SS_HOUR=${SUNSET%%:*}
SS_MIN=${SUNSET##*:}
SUNSET_MIN=$((SS_HOUR*60 + SS_MIN))

if (( NOW >= SUNRISE_MIN && NOW < SUNSET_MIN )); then
    plasma-apply-colorscheme BreezeLight
else
    plasma-apply-colorscheme BreezeDark
fi
