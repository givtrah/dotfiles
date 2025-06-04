#!/usr/bin/env bash

# Configuration
ICON_SYMBOL="" # Example Nerd Font symbol (e.g., cloud) - replace with your desired symbol
RED_COLOR="#e06c75" # Example red color
GREEN_COLOR="#98c379" # Example green color
DEFAULT_COLOR="#abb2bf" # Example default color (e.g., grey/white)
LOG_FILE="/tmp/maestral_waybar_monitor.log" # For debugging purposes

# Function to update Waybar output (prints JSON to stdout)
update_waybar_output() {
    local color="$1"
    local text="$2"
    echo "{\"text\": \" $ICON_SYMBOL \", \"tooltip\": \"$text\", \"class\": \"maestral-status\", \"alt\": \"maestral\", \"percentage\": 100, \"style\": \"color: $color;\"}"
}

# Check Maestral status
# Ensure 'maestral' is in your user's PATH or provide the full path to the executable.
status_output=$(maestral status 2>&1) 
echo "$(date): Checking Maestral status: $status_output" >> "$LOG_FILE"

if echo "$status_output" | grep -q "Could not load auth token"; then
    echo "$(date): Auth token error detected. Outputting red status." >> "$LOG_FILE"
    update_waybar_output "$RED_COLOR" "Auth Error"
    
    echo "$(date): Running 'maestral stop' then 'maestral start'..." >> "$LOG_FILE"
    maestral stop >> "$LOG_FILE" 2>&1
    maestral start >> "$LOG_FILE" 2>&1
    
elif echo "$status_output" | grep -q "Status *Up to date"; then
    echo "$(date): 'Up to date' status detected. Outputting green status." >> "$LOG_FILE"
    update_waybar_output "$GREEN_COLOR" "Up to date"
else
    echo "$(date): Unknown Maestral status. Outputting default status." >> "$LOG_FILE"
    update_waybar_output "$DEFAULT_COLOR" "Unknown"
fi
