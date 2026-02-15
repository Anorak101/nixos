{pkgs, inputs, ...}: 
{
    home.packages = (with pkgs; [ #`home.packages` if using home manager
        # replace or repeat for any included package
        inputs.nix-citizen.packages.${system}.rsi-launcher
    ]);

}
