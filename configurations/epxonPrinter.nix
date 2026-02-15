{ inputs, pkgs, ... }:
{
  services.printing = { enable = true; drivers = [ pkgs.epson-escpr ]; };
  services.avahi = { enable = true; nssmdns4 = true; };
  environment.systemPackages = [
    pkgs.epson-escpr
  ];
}
