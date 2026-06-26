{ pkgs }:

pkgs.writeShellApplication {
  name = "waybar-reload";

  runtimeInputs = with pkgs; [
    waybar
    procps    # Provides pgrep
    util-linux # Provides kill (though usually built-in, this ensures compatibility)
    coreutils  # Provides sleep, echo
    uwsm
  ];

  text = ''
    # Find the Process ID (PID) of Waybar
    # Using -u $USER ensures you only kill your own instance
    CURRENT_USER=$(whoami)
    PID=$(pgrep -u "$CURRENT_USER" waybar || true)

    # Check if Waybar is running
    if [ -z "$PID" ]; then
      echo "Waybar is not running."
    else
      # Kill the Waybar process
      echo "Killing Waybar (PID: $PID)..."
#      kill "$PID"
      pkill waybar
      sleep 1 
    fi

    # Start Waybar in the background
    echo "Starting Waybar..."
    # 'disown' prevents the script from hanging or closing waybar when it exits
    # waybar & disown

    uwsm app -- waybar &

    echo "Script finished."
  '';
}
