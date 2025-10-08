{ desktop, username, host, nix-version, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = nix-version;

  home.username = username;
  home.homeDirectory = "/home/${username}";

  imports = [
    ./home

    ];
}
