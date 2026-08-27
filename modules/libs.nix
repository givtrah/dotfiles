{ config, lib, pkgs, ... }:

{

  # fix non-nix programs not working (taken from https://nix.dev/guides/faq.html) 
#  programs.nix-ld.enable = true;
#  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    # consider using "steam-run" to run non-nix programs
#  ]; 

# https://unix.stackexchange.com/questions/522822/different-methods-to-run-a-non-nixos-executable-on-nixos

 programs.nix-ld.enable = true;
      programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc
        openssl

# old X libs unsure what its used for atm
	libxcomposite
        libxtst
        libxrandr
        libxext
        libx11
        libxfixes
        libGL
        libva
        pipewire
        libxcb
        libxdamage
        libxshmfence
        libxxf86vm
        libelf
        
        # Required
        glib
        gtk2
        bzip2
        
        # again old xorg libs # Without these it silently fails
        libxinerama
        libxcursor
        libxrender
        libxscrnsaver
        libxi
        libsm
        libice
#        gnome2.GConf # removed on 2024-12-29 due to compile error
        nspr
        nss
        cups
        libcap
        SDL2
        libusb1
        dbus-glib
        ffmpeg

        # Only libraries are needed from those two
        libudev0-shim
        
        # Verified games requirements
        libxt
        libxmu
        libogg
        libvorbis
        SDL
        SDL2_image
        glew_1_10
        libidn
        tbb
        
        # Other things from runtime
        flac
        freeglut
        libjpeg
        libpng
        libpng12
        libsamplerate
        libmikmod
        libtheora
        libtiff
        pixman
        speex
        SDL_image
        SDL_ttf
        SDL_mixer
        SDL2_ttf
        SDL2_mixer
        # libappindicator-gtk2
        # libdbusmenu-gtk2
        # libindicator-gtk2
        libcaca
        libcanberra
        libgcrypt
        libvpx
        librsvg
        libxft
        libvdpau
        pango
        cairo
        atk
        gdk-pixbuf
        # fontconfig
        freetype
        dbus
        alsa-lib
        expat
        
        # Needed for electron
        libdrm
	mesa
        libxkbcommon
      ];
}



