{ lib, stdenv, pkgs, appimageTools, gsettings-desktop-schemas, gtk3, fetchurl, ...}:
let
  version = "02.01.01.52";
  appImage = fetchurl {
    url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/Bambu_Studio_linux_fedora-v${version}.AppImage";
    sha256 = "sha256-huMKtNMW7UqsiyRuielGbF4wjUH1Jwv2tcQIBSqFqhM=";
  };
in
appimageTools.wrapType2 {
  pname = "bambu-studio";
  inherit version;

  src = appImage;

  extraPkgs = pkgs: (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs) ++ (with pkgs; [
    # fixes "unexpected error"
    gsettings-desktop-schemas glib gtk3 zlib

    # needed for icons
    adwaita-icon-theme
  ]);
}
