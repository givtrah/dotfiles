# nix-config
Nixos files for my installations

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
git clone git@github.com:givtrah/nix-config
```
or use https 
(note: Change git repo from https to ssh afterwards in git config!)
```
git clone https://github.com/givtrah/nix-config
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


# Nix os commands in dir

Update system according to the flake and nix files
```
sudo nixos-rebuild boot --flake . --impure

(impure for now, asahi only works well with impure and I have other issues as well that requires impure for now until I solve the issues)
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

Remember to check lsblk

Enter root password at the end, then reboot

Upon reboot:

Login as root

nix-shell -p git

git clone repo

export TMPDIR=/tmp
(or you WILL run out of space during installation).

CHANGE THE STATE VERSION IN THE GIT REPO nix-config/nixos/hosts/*/default.nix to MATCH /etc/nixos/configuration.nix!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Add experimental flake and nix settings to configuration.nix in /etc/nixos/configuration.nix by adding the line
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

Then run
nixos-rebuild switch

Finally do (while standing in the nix-config dir)

nixos-rebuild switch --flake ./#HOSTNAME-WANTED --impure


 






