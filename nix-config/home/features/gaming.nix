{ config, pkgs, ...}: {

  gtk = {
    enable = true;
    };


home.pointerCursor = {
  x11.enable = true;
  gtk.enable = true;
  package = pkgs.catppuccin-cursors.mochaSapphire;
  name = "catppuccin-mocha-sapphire-cursors";
  size = 48;
};



  home.packages = with pkgs; 

  [

# remoteplay
  moonlight-qt
  sunshine

  # Emulation
  
#  retroarchFull # multi system with all cores (should be changed to NOT mame, but everything else)

  mednafen # multisystem emulator
  mednaffe # frontend for mednafen

#  desmume # Nintendo DS - not compiling 2024-12-29
  melonDS # Nintendo DS
#  lime3ds # Nintendo 3DS
  mgba # Nintendo Gameboy Advance
  sameboy # Nintendo Gameboy, Gameboy color, Super Gameboy
  fceux # NES
  punes-qt6 # NES
#  snes9x-gtk # SNES
#  nanoboyadvance # Nintendo Gameboy Advance - not compiling 2024-12-29
  dolphin-emu # Nintendo Gamecube / Wii / triforce
  ryujinx # Nintendo Switch

#  duckstation # PS1 # moved to x86 only as it does not compile on aarch64 2024-12-31
#  pcsxr # PS1
  ppsspp-sdl-wayland # Playstation portable (wayland)
  rpcs3 # PS3
  
  maxcso # compression from iso to cso for psp and ps2 emus
 
  dosbox # Dos games
 
  xemu # original xbox 
 
  dgen-sdl # Sega Genesis / Megadrive
  flycast # Sega Dreamcast, Naomi and Atomiswave emulator

  stella # Atari 2600
  openmsx # MSX
#  fsuae # Amiga, not working right now
#  uae # Amiga - failed to build on 2024-12-29
  vice # C-64

#  emulationstation # Frontend currently with security issues


#  heroic # heroic launcher
#  gogdl # gog downloader for heroic

  scummvm

  mangohud



  ]

  ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ ]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ 
	steam
        mupen64plus # Nintendo 64
        pcsx2 # PS2
        cemu # Wii x86 only
        zsnes # SNES x86 only
        duckstation # does not compile on aarch64 2024-12-31
#        heroic - failed to build 2024-12-29



      ]
      else []));


















}
