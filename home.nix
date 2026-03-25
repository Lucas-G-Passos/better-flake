{
  config,
  ...
}:
{
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";
  home.stateVersion = "25.11";
  home.file = {
    ".config/quickshell".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/configs/quickshell";
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
  ];
}
