{ pkgs, ... }:
{
  gtk = {
    iconTheme = pkgs.rose-pine-icon-theme;
    cursorTheme = pkgs.rose-pine-cursor;
    theme = pkgs.rose-pine-gtk-theme;
  };
}
