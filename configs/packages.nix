{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    ripgrep
    fzf
    bat
    yarn
    vscode-fhs
    eza
    kitty
    font-manager
    papirus-icon-theme
    rofi
    kdePackages.qtdeclarative
    home-manager
    qt6Packages.qt6ct
    ripdrag
    pavucontrol
    obsidian
    basalt
  ];

  programs = {
    yazi = {
      enable = true;
      enableFishIntegration = true;
      plugins = {
        drag = pkgs.yaziPlugins.drag;
        git = pkgs.yaziPlugins.git;
      };
    };
    kitty = {
      enable = true;
      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        size = 12;
        name = "Jetbrains Mono Nerd Font";
      };
    };
    lazygit = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
