{ pkgs, ... }: {
  home.packages = (with pkgs; [ 
    dotnetCorePackages.sdk_9_0-bin 
    mono
    #dotnetCorePackages.aspnetcore_9_0-bin
    #dotnetCorePackages.dotnet_9.sdk
  ]);
}
