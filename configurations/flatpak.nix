# https://github.com/Frost-Phoenix/nixos-config/blob/main/modules/core/flatpak.nix

{ inputs, pkgs, ... }:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    packages = [
      #"com.github.tchx84.Flatseal"
      # "io.github.everestapi.Olympus"
      #{ appId = "com.bambulab.BambuStudio"; origin = "flathub"; }
    ];
  };
}
