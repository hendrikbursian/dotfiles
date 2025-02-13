{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Fonts
    (pkgs.nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
    font-awesome

    # User
    comma
    devenv
    eza
    nix-index
    pdftk
    socat
    tldr
    wget
    wl-clipboard
    sloc
    lynx
    w3m
    unstable.yt-dlp
    ffmpeg
    visidata
    clight
    inotify-tools
    gnuplot
    slurp
    grim

    # Apps
    bitwarden
    scribus
    onlyoffice-bin_latest
    vlc
    brave
    firefox
    telegram-desktop
    zathura
    teams-for-linux
    audacity
    gimp
    imagemagick
    obsidian
    openai-whisper
    teamspeak5_client
    protonmail-desktop
  ];

}
