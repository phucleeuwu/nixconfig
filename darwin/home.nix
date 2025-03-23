{pkgs, ...}: {
  imports = [
    ../home.nix
  ];
  # macOs only packages
  home.packages = [
    pkgs.arc-browser
    pkgs.raycast
    pkgs.iina
  ];
  aerospace.enable = true;
}
