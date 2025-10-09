{ pkgs, ... }: {
  imports = [
    ./hyprland_minimal.nix
    ./obsidian.nix
    #./thunderbird.nix
    ./blender.nix
    # ./wine.nix
    # ./webex.nix
    ./bambu-studio.nix
    ./godot.nix
    ./gobuster.nix
    ./open-vpn.nix
 ];

  home.packages = (with pkgs; [
    # default apps 
    mpv                               # simple video player
    evince                            # simple pdf viewer
    imv                               # simple image viewer

    xdg-utils

    # GUI Apps
    vlc                               # video player 
    libreoffice
    
    webcamoid
    
    spotify
    discord
    
    filezilla        
    
    bleachbit                         # cache cleaner
    gnome-calculator                  # calculator
    
    winetricks
    wineWowPackages.wayland
 ]);
}
