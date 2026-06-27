{ pkgs }:

pkgs.writeShellScriptBin "waybar-reload" ''
  PATH="${with pkgs; lib.makeBinPath [ waybar sysvinit coreutils uwsm ]}:$PATH"

  # Find the exact PID of the waybar binary using pidof
  PID=$(pidof waybar || true)

  if [ -n "$PID" ]; then
    echo "Stopping active Waybar instances (PIDs: $PID)..."
    
    # Kill the exact PIDs found
    kill $PID || true
    sleep 1

    # Force kill fallback if the socket doesn't unbind immediately
    REMAINING=$(pidof waybar || true)
    if [ -n "$REMAINING" ]; then
      echo "Forcing termination..."
      kill -9 $REMAINING || true
      sleep 0.5
    fi
  else
    echo "Waybar is not currently running."
  fi

  echo "Launching Waybar natively via UWSM application tracking..."
  uwsm app -- waybar > "$HOME/.cache/waybar-reload.log" 2>&1 &

  echo "Script finished cleanly."
''
