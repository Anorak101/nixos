{pkgs-unstable, ...}: {
  environment.systemPackages = [
    pkgs-unstable.bluez
  ];
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        AutoEnable = true;
        ControllerMode = "bredr";
      };
    };
  };
  services.blueman.enable = true;

}
