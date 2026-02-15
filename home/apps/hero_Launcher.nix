{ pkgs, pkgs-unstable, ... }: {
  #home-manager.extraSpecialArgs = { inherit unstable; };
  home.packages = (with pkgs; [ heroic]);
  }
