#!/usr/bin/env bash

# Configuration
ICON_SYMBOL="" # Example Nerd Font symbol
# RED_COLOR="#e06c75" # No longer needed in script if using CSS classes
# GREEN_COLOR="#98c379"
# DEFAULT_COLOR="#abb2bf"
LOG_FILE="/tmp/maestral_waybar_monitor.log"

# Function to update Waybar output
update_waybar_output() {
    local css_class="$1" # This will be the dynamic class name
    local text="$2"
    # Notice the 'class' attribute is now dynamic, and 'style' is removed
    echo "{\"text\": \" $ICON_SYMBOL \", \"tooltip\": \"$text\", \"class\": \"maestral-status $css_class\", \"alt\": \"maestral\", \"style\": \"color: #ff0000;\"}"
}

status_output=$(maestral status 2>&1) 
echo "$(date): Checking Maestral status: $status_output" >> "$LOG_FILE"

if echo "$status_output" | grep -q "Could not load auth token"; then
    echo "$(date): Auth token error detected. Outputting red status." >> "$LOG_FILE"
    update_waybar_output "error" "Auth Error" # Use class "error"

    echo "$(date): Running 'maestral stop' then 'maestral start'..." >> "$LOG_FILE"
    maestral stop >> "$LOG_FILE" 2>&1
    maestral start >> "$LOG_FILE" 2>&1

elif echo "$status_output" | grep -q "Status *Up to date"; then
    echo "$(date): 'Up to date' status detected. Outputting green status." >> "$LOG_FILE"
    update_waybar_output "up-to-date" "Up to date" # Use class "up-to-date"
else
    echo "$(date): Unknown Maestral status. Outputting default status." >> "$LOG_FILE"
    update_waybar_output "unknown" "Unknown" # Use class "unknown"
fi
