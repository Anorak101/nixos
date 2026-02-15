{...}:
{
services.zerotierone = {
  enable = true;
    #joinNetworks = [ "YOUR_NETWORK_ID" ]; # Replace with your actual ZeroTier Network ID
  # Optional: open the default port in the firewall
  port = 9994;
};

}
