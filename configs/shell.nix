{ ... }:
{
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza --icons";
      lsa = "eza -la --icons";
      reb = "sudo nixos-rebuild switch --flake ~/nixos#$(hostname)";
      cat = "bat";
      cd = "z";
      se = "nix-search";
    };

    interactiveShellInit = "
    set fish_greeting ''
    starship init fish | source
    ";
    generateCompletions = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableInteractive = false;
    enableTransience = false;
  };

  programs.carapace = {
    enable = true;
    enableFishIntegration = true;
  };
}
