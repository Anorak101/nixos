{ host, ... }: {
  imports = [
    # Base
    ./nix_stuff.nix
    #./local.nix
    ./user.nix
    ./clean.nix
    #./sops.nix

  ]
      ++ (if host == "laptop" then
      [
        ../hardware-configuration.nix
        
        # Drivers
        ./bootloader.nix
        ./graphics.nix
        ./monitor_cpu_temp.nix
        ./networking.nix
        #./networking.nix
        ./audio.nix
        ./printing.nix
        ./bluetooh.nix
        ./fingerprint.nix
        ./usb_auto_mount.nix
        ./battery.nix

        # Windows
        ./display_manager.nix
        ./window_manager

        # Apps
        #./syncthing.nix
        #./wireguard.nix
        #./mullvad_gui.nix

        # Gaming
        ./steam.nix

        # Other
        #./server/debug_tools.nix 
        #./server/hotspot.nix 

        # Eden
        #./dlr_eden_postgress.nix
        #./docker.nix

        ./filebrowser.nix

      ] else [])
    ++ (if host == "PC" then
      [
        ../hardware-configuration.nix
        
        # Drivers
        ./bootloader.nix
        ./graphics.nix
        ./monitor_cpu_temp.nix
        ./networking.nix
        ./nvidia.nix
        ./networking.nix
        ./audio.nix
        ./printing.nix
        ./usb_auto_mount.nix
        ./fix_stuck_on_tpmrm0.nix
        #./sops.nix

        # Windows
        ./display_manager.nix
        ./window_manager

        # Apps
        #./syncthing.nix
        #./wireguard.nix

        # Gaming
        ./steam.nix
        #./mullvad_gui.nix

      ] else []);
}
