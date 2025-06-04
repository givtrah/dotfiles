#!/usr/bin/env bash

# Strict mode: exit on error, treat unset variables as an error,
# and ensure pipeline failures are propagated.
set -euo pipefail

# --- Configuration ---
# Source directory: expected to be a 'config' subdirectory in the current working directory.
SOURCE_DIR="config"
# Target directory: the standard user-level configuration directory.
TARGET_DIR="$HOME/.config"

# --- Script Start ---
echo "Initializing configuration symlinker..."
echo "----------------------------------------"

# --- Sanity Checks ---
# 1. Check if the source directory exists.
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' not found."
    echo "Please ensure a 'config' directory exists in the current location from where you are running this script."
    exit 1
fi
echo "Source directory found: $(realpath "$SOURCE_DIR")"

# 2. Ensure the target directory exists, create it if not.
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory '$TARGET_DIR' not found. Creating it..."
    mkdir -p "$TARGET_DIR"
    if [ $? -eq 0 ]; then
        echo "Successfully created target directory: $TARGET_DIR"
    else
        echo "Error: Failed to create target directory '$TARGET_DIR'."
        exit 1
    fi
else
    echo "Target directory already exists: $TARGET_DIR"
fi
echo "----------------------------------------"
echo "Starting symlinking process..."
echo ""

# --- Main Logic: Find and Symlink Directories ---
# Use 'find' to locate all directories (-type d) directly under SOURCE_DIR (-mindepth 1 -maxdepth 1).
# -print0 and 'read -r -d $'\0'' handle directory names with spaces or special characters.
find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -type d -print0 | while IFS= read -r -d $'\0' source_item_path; do
    # Extract the base name of the directory (e.g., "nvim" from "./config/nvim").
    item_name=$(basename "$source_item_path")
    # Construct the full path for the intended symlink in the target directory.
    target_link_path="$TARGET_DIR/$item_name"

    echo "Processing directory: '$item_name'"

    # Resolve the source path to an absolute path. This makes symlinks more robust,
    # as they will point to the correct absolute location regardless of where they are created
    # or how the script is invoked.
    absolute_source_path=$(realpath "$source_item_path")

    # Check if a file, directory, or symlink already exists at the target path.
    # The -L flag checks if it's a symlink (even a broken one).
    # The -e flag checks for general existence.
    if [ -L "$target_link_path" ]; then
        # Target exists and is a symlink. Check if it points to the correct location.
        if [ "$(realpath "$target_link_path")" = "$absolute_source_path" ]; then
            echo "  -> Already correctly symlinked: '$target_link_path' -> '$absolute_source_path'. Skipping."
        else
            echo "  -> Warning: '$target_link_path' is a symlink but points to a different location: $(realpath "$target_link_path" 2>/dev/null || echo 'broken link'). Skipping."
            echo "     Expected to point to: '$absolute_source_path'"
        fi
    elif [ -e "$target_link_path" ]; then
        # Target exists but is not a symlink (it's a regular file or directory).
        echo "  -> Warning: '$target_link_path' already exists and is not a symlink. Skipping to avoid overwrite."
    else
        # Target does not exist, so we can create the symlink.
        echo "  -> Creating symlink: '$target_link_path' -> '$absolute_source_path'"
        ln -s "$absolute_source_path" "$target_link_path"
        echo "  -> Successfully created symlink."
    fi
    echo "---"
done

echo ""
echo "----------------------------------------"
echo "Configuration symlinking complete."
echo "All found directories in '$SOURCE_DIR' have been processed."
 
