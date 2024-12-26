{ config, pkgs, lib, ... }:

let
  user = "hendrik";
in
{
  imports = [
    ./hardware-configuration.nix

    ../../modules/power-management.nix

    ../../modules/nvidia.nix

    ../../modules/plymouth.nix
    ../../modules/system-pkgs.nix
    ../../modules/gnome.nix

    ../../modules/users/${user}.nix
  ];

  power-management.module = false;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = false;

  boot.initrd.luks.devices."swap".device = "/dev/disk/by-uuid/9bd94eff-c5b8-4fe1-a90a-53996b1b956b";

  boot.initrd.availableKernelModules = [
    # Source: https://nixos.wiki/wiki/Full_Disk_Encryption
    "aesni_intel"
    "cryptd"
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    tuxedo-keyboard
  ];

  # Keyboard backlight
  boot.kernelParams = [
    "tuxedo_keyboard.mode=0"
    "tuxedo_keyboard.brightness=0"
    "tuxedo_keyboard.color_left=0xffffff"
  ];

  # Display backlight
  programs.light.enable = true;

  hardware.tuxedo-keyboard.enable = true;
  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };

  # Bootloader.
  # boot.kernel.sysctl = { "net.ipv4.ip_unprivileged_port_start" = 0; };
  fileSystems."/boot".options = [ "umask=0077" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 22;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    networkmanager.enable = true;
    hostName = "tuxedo";
    wireless.enable = false;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.supportedLocales = [
    "de_DE.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.getty.autologinUser = user;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  # Needed for swaylock to work
  security.pam.services.swaylock = { };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

    # Low latency
    # extraConfig.pipewire."92-low-latency" = {
    #   context.properties = {
    #     default.clock.rate = 48000;
    #     default.clock.quantum = 32;
    #     default.clock.min-quantum = 32;
    #     default.clock.max-quantum = 32;
    #   };
    # };
  };

  environment.pathsToLink = [ "/share/zsh" ];
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  nixpkgs.config.allowUnfree = false;

  programs.zsh.enable = true;

  programs.nh = {
    enable = true;
    flake = "/home/${user}/Workspace/dotfiles";
  };

  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.package = pkgs.docker_25;
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192; # Use 8192MiB memory.
      cores = 12;
    };
  };

  nix = {
    package = pkgs.nixVersions.stable;
    channel.enable = false;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      trusted-users = [ "root" user ];
    };
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 1month";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
