#!/usr/bin/env bash

# Default directory
DEFAULT_DIR="$HOME/Dropbox/pics/walls" # You can change this to your desired default path

# Check if an argument (directory) is provided
if [ -z "$1" ]; then
  DIR="$DEFAULT_DIR"
  echo "No directory provided. Using default: $DIR"
else
  DIR="$1"
fi

# Check if the directory exists
if [ ! -d "$DIR" ]; then
  echo "Error: Directory '$DIR' not found."
  exit 1
fi

# Find all files, pipe them to shuf to pick one random line,
# then read that single line into the 'img' variable.
find "$DIR" -type f | shuf -n 1 | while read -r img; do
  hyprctl hyprpaper reload , "$img"
  wallust run "$img"
done
