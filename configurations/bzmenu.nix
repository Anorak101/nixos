{ inputs, pkgs, ... }:
{
  environment.systemPackages = [ inputs.bzmenu.packages.${pkgs.system}.default ];
}
