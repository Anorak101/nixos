{ ... }: {
  programs.ssh = { 
    enable = true;
    matchBlocks = {
      behnserver = {
        hostname = "192.168.178.39";
        user = "Anorak";
      };

      asus = {
        hostname = "192.168.178.2";
        user = "Anorak";
      };
    }; 
  };
}
