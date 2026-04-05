{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      limine.enable = true;
    };
    initrd.systemd.network.wait-online.enable = false;
    # plymouth = {
    #   enable = true;
    # };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  users.users.lucas = {
    isNormalUser = true;
    description = "lucas";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "gamemode"
    ];
    shell = pkgs.fish;
  };

  console.useXkbConfig = true;

  environment.systemPackages = with pkgs; [
    micro
    nixfmt
    nixd
    neovim
    tree
    git
    file
    nix-search-cli
    libreoffice-qt6-fresh
    font-manager
    quickshell
    brightnessctl
    networkmanagerapplet
    unzip
    python3
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.jetbrains-mono
    fira-code
  ];

  services = {
    playerctld.enable = true;
    udisks2.enable = true;
    tailscale.enable = true;
    hypridle.enable = true;
    pipewire.pulse.enable = true;
    gvfs.enable = true;

    upower.enable = true;
    blueman.enable = true;
    tlp.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    xserver.xkb = {
      layout = "br";
      variant = "thinkpad";
    };
    xserver.enable = false;
  };

  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
    steam.enable = true;
    java.enable = true;
    fish.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    chromium.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
  };

  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  systemd.network.wait-online.enable = false;

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  system.stateVersion = "25.11";

}
