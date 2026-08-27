{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  # FOR NOW THIS ASSUMES AN X86_X64 HOST!

  [
    # Emulators
    fsuae           # Amiga
    fsuae-launcher  # FSUAE front-end
    stella          # Atari 2600 



    mupen64plus     # Nintendo 64
    desmume         # Nintendo DS
    melonds         # Nintendo DS
    dolphin-emu     # Nintendo Gamecube / Wii / triforce
    nanoboyadvance  # Nintendo Gameboy Advance
    mgba            # Nintendo Gameboy Advance
    sameboy         # Nintendo Gameboy, Gameboy color, Super Gameboy

    eden            # Nintendo Switch 1
    ryubing         # Nintendo Switch 1
    cemu            # Nintendo Wii

#    fceux-qt6       # NES
    punes-qt6       # NES
    snes9x          # SNES - does not build
    zsnes           # SNES

    mednafen        # Multisystem (incl. PSX/PS1)
    mednaffe        # Frontend for mednafen
    mesen           # Multisystem
    retroarch-full  # Multisystem

    flycast         # SEGA Dreamcast, Naomi and Atomiswave
    dgen-sdl        # SEGA Genesis / Megadrive
    dosbox          # DOS games

    xemu            # Original xbox
    xenia-canary    # Xbox 360

    scummvm         # SCUMM games

    pcsx2           # PS2
    # rpcs3           # PS3 - not building 2026-07-03

    ppsspp-sdl-wayland # Playstation portable (wayland)

    # Game utilities
    rusty-path-of-building # POE1 and POE2 build planner
    maxcso # compression from iso to cso for psp and ps2 emulators
    mangohud    

    # Remote play
    # moonlight-qt
    # sunshine

#  openmsx # MSX - not compiling 2025-08-23
#  vice # C-64

  ];

}
