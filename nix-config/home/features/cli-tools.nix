{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [

    luarocks
    neofetch
    nnn # terminal file manager
  
    
    htop

    # replacements
    eza # ls replacement (exa, maintained, aliased to ls)
    bat # cat replacement (aliased to cat)
    ripgrep # grep replacement (not aliased)
    zoxide # cd replacement (aliased to cd)
    fd # find replacement (not aliased)
    

    # replacements end

    dua # du improved / interactive version

    kew # command-line music player

    yt-dlp # youtube downloader

    hugo
    ffmpeg
    streamlink

    killall

    lm_sensors

    # archives
    zip
    xz
    unzip
    p7zip
    unrar
#    rar   # does not exist on aarch64

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
#    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
#    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

#    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb



#    maestral
#    maestral-gui

    fastfetch




  btop
  tmux



# v4l-utils
#  guvcview


  smartmontools
#  gsmartcontrol
  # productivity / work
  
  autossh # FW passthrough


  # System tools
  dmidecode # for hardware information
  inxi # for hardware information
  lm_sensors # temps


  # for printing
  libusb1




  ];

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };



}
