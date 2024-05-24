#!/bin/bash

# IP address of the server. IMPORTANT!!!! 
# CHANGE TO THE STATIC IP OF YOUR SERVER!
SERVER_IP="x.x.x.x"

# Path to the log file and the state file
# can be anything the script has write access to
LOG_FILE="$HOME/scripts/logs/ping-server.log"
STATE_FILE="$HOME/scripts/logs/server.state"

# Read the last known state
if [ -f "$STATE_FILE" ]; then
    LAST_STATE=$(<"$STATE_FILE")
else
    LAST_STATE="unknown"
fi

# Ping the server and check if it's up
ping -c 4 $SERVER_IP > /dev/null 2>&1
RESULT=$?

# Check current state based on ping result and
# log the results into a log file.
if [ $RESULT -eq 0 ]; then
    CURRENT_STATE="up"
    echo "$(date): Server is up!" >> $LOG_FILE
else
    CURRENT_STATE="down"
    echo "$(date): Server is down!" >> $LOG_FILE
fi

# Store current state
echo "$CURRENT_STATE" > "$STATE_FILE"

# Check for state change and execute corresponding command
if [ "$LAST_STATE" != "$CURRENT_STATE" ]; then
    if [ "$CURRENT_STATE" = "down" ]; then
        # Command to run when the server goes down
        # YOUR DOWN STATE COMMAND GOES HERE
        /path/to/down/command
    elif [ "$CURRENT_STATE" = "up" ]; then
        # Command to run when the server goes up
        # YOUR UP STATE COMMAND GOES HERE
        /path/to/up/command
    fi
fi

# Check the number of lines in the log file and remove 
# the oldest if it exceeds 9000 to save space.
# The speed the log file will fill up on depends 
# on the way you time the script. For example, running
# it once every minute means 9000 lines is enough
# for just under 1 week of logs. Run it once every
# 5 minutes however, and you get a month and a bit.
MAX_LINES=9000
CURRENT_LINES=$(wc -l < "$LOG_FILE")

if [ $CURRENT_LINES -gt $MAX_LINES ]; then
    # Calculate number of lines to remove
    LINES_TO_REMOVE=$(($CURRENT_LINES - $MAX_LINES))
    # Remove the oldest lines
    tail -n $MAX_LINES "$LOG_FILE" > "$LOG_FILE.tmp"
    mv "$LOG_FILE.tmp" "$LOG_FILE"
fi
