{ host, ... }: {
  imports = [
    # Base
    ./nix_stuff.nix
    ./local.nix
    ./user.nix
    ./clean.nix
    ./sops.nix

  ] ++

    [
      ../hardware-configuration.nix

      # Drivers
      ./bootloader.nix
      ./graphics.nix
      ./monitor_cpu_temp.nix
      ./networking.nix
      ./audio.nix
      ./printing.nix
      ./bluetooh.nix
      ./fingerprint.nix
      ./usb_auto_mount.nix
      ./battery.nix

      # Windows
      ./display_manager.nix
      ./window_manager

      # Gaming
      ./steam.nix


    ];
}
