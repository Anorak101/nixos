{ pkgs, ... }: {
  programs.git = {
    enable = true;

    userName = "Anorak101";
    userEmail = "anorak321@gmail.com"; 


    extraConfig = {
      url = {
        "git@github.com" = {
          insteadOf = [
            "https://github.com"
          ];
        };
      };
      init.defaultBranch = "main";
      credential.helper = "store";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      pull.rebase = false;
    };

    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = true;
        diff-so-fancy = true;
        navigate = true;
      };
    };
  };

  home.packages = [ pkgs.gh ]; # pkgs.git-lfs
}
