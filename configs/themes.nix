{ pkgs, config, ... }:
{
  # gtk = {
  #   enable = true;

  #   iconTheme = {
  #     name = "rose-pine-moon";
  #     package = pkgs.rose-pine-icon-theme;
  #   };

  #   cursorTheme = {
  #     name = "BreezeX-RosePine-Linux";
  #     package = pkgs.rose-pine-cursor;
  #     size = 24;
  #   };

  #   theme = {
  #     name = "rose-pine-moon";
  #     package = pkgs.rose-pine-gtk-theme;
  #   };

  #   gtk3.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #   };

  #   gtk4.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #   };
  #   gtk4.theme = null;
  # };

  gtk = {
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };

  home.pointerCursor = {
    gtk.enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 24;
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 24;
  };
}
