#!/usr/bin/env bash

# Find the Process ID (PID) of Waybar
PID=$(pgrep waybar)

# Check if Waybar is running
if [ -z "$PID" ]; then
  echo "Waybar is not running."
else
  # Kill the Waybar process
  echo "Killing Waybar (PID: $PID)..."
  kill "$PID"
  sleep 1 # Give it a moment to terminate
fi

# Start Waybar in the background
echo "Starting Waybar..."
waybar &

echo "Script finished."
