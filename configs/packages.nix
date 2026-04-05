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
  ];

  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
      name = "Jetbrains Mono Nerd Font";
    };
  };
}
