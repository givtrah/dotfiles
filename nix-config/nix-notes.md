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






