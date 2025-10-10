{ username, pkgs, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Johannes Hinrichs";
    extraGroups = [
      "networkmanager"
      "wheel"
      "media"
      "nginx"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
