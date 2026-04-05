{
  config,
  pkgs,
  ...
}:
{
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";
  home.stateVersion = "25.11";
  home.file = {
    ".config/quickshell".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/configs/quickshell";
    ".config/hypr".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/configs/hyprland";
  };
  home.sessionVariables = {
    QMLLS_BUILD_DIRS = "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml/:${pkgs.quickshell}/lib/qt-6/qml/";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    EDITOR = "micro";
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Lucas-G-Passos";
        email = "lucasgodpassos@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  imports = [
    ./configs/packages.nix
    ./configs/shell.nix
    ./configs/themes.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
