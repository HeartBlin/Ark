{ ... }:

{
  config.Ark = {
    displayManagers.gdm.enable = true;
    flakeDir = "/home/heartblin/Documents/Ark";
    hardware = {
      cpu = { };
      gpu = {
        hybrid = true;
        type = "nvidia";
        ids = {
          amd = "PCI:6:0:0";
          nvidia = "PCI:1:0:0";
        };
      };
    };

    timeZone = "Europe/Bucharest";
    manufacturer = "asus";

    home = {
      git = {
        user = "HeartBlin";
        email = "Manea.Emil@proton.me"; # Doxxed lel
        signKey = "~/.ssh/GithubSign.pub";
      };

      gnome.enable = true;
      steam.enable = true;
      vscode.enable = true;
    };
  };
}
