{ pkgs }:

pkgs.writeShellApplication {
  name = "waybar-reload";

  runtimeInputs = with pkgs; [
    waybar
    procps
    util-linux
    coreutils
    uwsm
  ];

  text = ''
    CURRENT_USER=$(whoami)
    PID=$(pgrep -x -u "$CURRENT_USER" waybar || true)

    if [ -z "$PID" ]; then
      echo "Waybar is not running."
    else
      echo "Stopping active Waybar instances (PIDs: $PID)..."
      pkill -x waybar
      
      for _ in {1..2}; do
        if ! pgrep -x -u "$CURRENT_USER" waybar >/dev/null; then
          break
        fi
        sleep 1
      done

      if pgrep -x -u "$CURRENT_USER" waybar >/dev/null; then
        echo "Waybar is hung. Force-killing..."
        pkill -9 -x waybar
        sleep 0.5
      fi
    fi

    echo "Starting Waybar inside a native UWSM systemd unit..."
    
    # FIXED: Use 'uwsm app --' instead of 'uwsm env'.
    # We append '|| true' to protect against strict writeShellApplication rules,
    # and use a standard trailing '& disown' on the wrapper itself.
    uwsm app -- waybar || true &
    disown

    echo "Script finished."
  '';
}
