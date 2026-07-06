# nix-config
Nixos files for my installations
Currently using a Hyprland setup

# Wallpaper acknowledgements
Wallpapers are from these sources:

Shubham Dhage: https://unsplash.com/@theshubhamdhage
Egor Komarov: https://unsplash.com/@egorkomarov
Muhammad Arifur Rahman: https://www.vecteezy.com/members/arif_018

# How to use
Make sure git and gh is installed

You can start out by using a nix-shell that has gh and git:

```
nix-shell -p git gh
```

# Auth
```
gh auth login # login to github using ssh and auth token
```

# Tell git who you are
```
git config --global user.name "givtrah"

git config --global user.email "THESECRET@email.com"
```

# Clone repo
```
mkdir ~/.dotfiles
cd ~/.dotfiles
git clone git@github.com:givtrah/dotfiles .
```
or use https 
(note: Change git repo from https to ssh afterwards in git config!)
```
git clone https://github.com/givtrah/dotfiles .
```
# add all (new) files
```
git add .
```
# commit
```
git commit -m "reason"
```
# push
```
git push
```

# solve problems with repo being different from local
(by overwriting local with the repo)

```
git fetch --all
git reset --hard origin/main
git pull
```
If you feel you may use the local changes later you can do:

```
git stash
```
before doing the above fetch/reset/pull

then to reapply stashed changes later do:

```
git stash pop
```

# Overall directory structure
home: Home-manager stuff
hosts: Host-specific files
modules: Nix modules (e.g. non home-manager programs/services etc.)
secrets: SOPS-NIX secrets
wallpapers: Wallpapers

# Nix os commands in dir
Update system according to the flake and nix files
(note: impure system for now as asahi only really works well with impure...)
```
sudo nixos-rebuild boot --flake . --impure
```
Update the flake file (e.g. actually do an update! run update system above afterwards)
```
sudo nix flake update
```

# Solve home "backup" problems / interactions between existing config files and nixos trying to override
```
journalctl -e --unit home-manager-USERNAME.service
```
Will tell you the problematic config dir / file


# Reinstall notes
"Burn" KDE Nix OS iso to USB

Boot Nix OS, TURN OFF screen lock / sleep!

Use disko quickguide

Remember to check lsblk - USE /dev/disk/by-id, NOT JUST /dev/nvme* or /dev/sda - YOU WILL BE SORRY!

Enter root password at the end, then reboot

Upon reboot:

Login as root

nix-shell -p git gh sops

git clone repo

export TMPDIR=/tmp
(or you WILL run out of space during installation).

CHANGE THE STATE VERSION IN THE GIT REPO hosts/*/default.nix to MATCH /etc/nixos/configuration.nix!
CHANGE THE HOME-MANAGER VERSION IN flake.nix to MATCH current home-manager version!

REMEMBER TO IMPLEMENT SOPS FIRST! (unsure how to do this as its still to be tested)

Add experimental flake and nix settings to configuration.nix in /etc/nixos/configuration.nix by adding the line
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

Then run
```
nixos-rebuild switch
```
Finally do (while standing in the dotfiles dir)
```
nixos-rebuild switch --flake ./#HOSTNAME-WANTED --impure
```

# SOPS HOWTO
Generate quantum-safe SOPS private encryption key (yes, to prevent "store now, decrypt later")
```
sudo mkdir -p /var/lib/sops-nix/
age-keygen -pq -o /var/lib/sops-nix/keys.txt
```
Make sure this is stored safely!

At the top of this file, add: "username: USER" (without the quotes and where USER is your username)

Get public key for the SOPS private key:
```
age-keygen -y ~/var/lib/sops-nix/keys.txt
```

Create ".sops.yaml" in the root of the config:
```
keys:
  - &primary {{YOUR PUBLIC KEY HERE}} (ONLY THE PUBLIC KEY! The huge one! NOT THE PRIVATE KEY called AGE-SECRET-XXX)
creation_rules:
  - path_regex: secrets/secrets.yaml$
    key_groups:
    - age:
      - *primary
```

You can now edit secrets using:
```
sops secrets/secrets.yaml
```



