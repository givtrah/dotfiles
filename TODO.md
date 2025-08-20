# TODO for this nix-config

fix hyprland scripts so they work (and are nixified)

fix walker:

https://git.allpurposem.at/mat/Computer/src/commit/2ec271dad1a54b7678644318504c4e76d8a3d204/home-manager/modules/walker.nix

consider fixing nvim (or leave at is, but nixify the structe using home.file)

Add automatic garbage collection, general cleanup of hyprland

Add nixified hyprlock for when it no longer crashes on aarch64

setup zoxide correctly (YT)

Possible dark QT fix:
https://github.com/hyprwm/Hyprland/discussions/5867
# Garbage collection:

https://nix.dev/manual/nix/2.18/package-management/profiles

https://nixos.wiki/wiki/Storage_optimization



# List generations 
sudo nix-env -p /nix/var/nix/profiles/system --list-generations

# delete generations older than 7d
sudo nix-collect-garbage --delete-older-than 7d



# GC more..

https://github.com/NixOS/nix/issues/8508

https://discourse.nixos.org/t/home-manager-and-garbage-collection/41715/3

https://github.com/nix-community/home-manager/blob/master/modules/services/nix-gc.nix

https://discourse.nixos.org/t/how-to-get-rid-of-unused-home-manager-packages/14997

https://old.reddit.com/r/NixOS/comments/140z3hd/just_a_reminder_to_make_sure_garbage_collection/

https://nix.dev/manual/nix/2.18/package-management/garbage-collection

https://nixos.org/guides/nix-pills/11-garbage-collector






