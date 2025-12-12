#!/bin/bash

while true; do
	UPTIME_PRETTY=$(uptime -p)

	UPTIME_FORMATTED=$(echo "$UPTIME_PRETTY"| sed 's/^up //;s/,*$//;s/minute/m/; s/hour/h/; s/day/d/; s/s//g')

	echo " $UPTIME_FORMATTED"

	sleep 1
done
