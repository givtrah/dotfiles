{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
    # Standard utility replacements
    eza # ls replacement (exa, maintained, aliased to ls)
    bat # cat replacement (aliased to cat)
    ripgrep # recursively searches directories for a regex pattern (grep replacement - rg)
    zoxide # cd replacement (aliased to cd)
    fd # find replacement (not aliased)

    # various utilities
    tmux # terminal multiplexer 
    tldr      # better man
    gptfdisk  # sgdisk
		rename # perl-rename to use with regex
    killall
    nnn # terminal file manager
    yazi # terminal file manager
    nfs-utils
    autossh # FW passthrough
    glow # markdown previewer in terminal
    libusb1 # for printing
    xdg-utils
    bluetui # cli bluetooth manager (if needed)
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    file # provides file information (-i = mime info) 
    which
    gnused
    gnutar
    gawk
    zstd
    gnupg
    caligula # TUI disk-imaging tool
    age # Modern encryption tool used for SOPS-NIX

    # Systeminfo utils
    fastfetch
    htop
    btop
    amdgpu_top
    dua # du improved / interactive version
    smartmontools # for smartctl
    lm_sensors # temps / sensor command
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # System tools
    dmidecode # for hardware information
    inxi # for hardware information
    sysstat
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # Sound
    pulsemixer
    lame # mp3 encoder
    kew # command-line music player

    # Images


    # Video
    ffmpeg
    yt-dlp # youtube downloader
    streamlink
    v4l-utils
    # jellycli - broken 2026-07-21
    jellytui

    # Development
    rmapi # remarkable interface?
    lazygit # git helper
    hugo # static site generator
    luarocks
    yarn # Javascript package manager
    devenv # python development
    direnv
    nodejs
    bun
    gnumake
    cmake
    gcc

    # archives
    zip
    xz
    unzip
    p7zip
    unrar

    # nix related
    nix-output-monitor # provides the command 'nom' that works just like 'nix' with more detailed log output

  
  ];



}
