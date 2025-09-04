{ pkgs-unstable, local_domain, config, lib, ... }: 
let
  secrets = [
    "jellyfin/key"
    "qbittorrent/username"
    "qbittorrent/password"

    "prowlarr/key"
    "sonarr/key"
    "radarr/key"
    "lidarr/key"
    
    "home_assistant/key"
  ];

  to_var = (s: "HOMEPAGE_FILE_${lib.toUpper (builtins.replaceStrings ["/"] ["_"] s)}");
  to_sops = (s: "homepage/${s}");
  
  secret_vars = (builtins.foldl' 
    lib.recursiveUpdate 
    {} 
    (builtins.map 
      (s: builtins.foldl' 
        (set: s: builtins.listToAttrs [{ name = s; value = set; }])
        (to_var s)
        (lib.lists.reverseList (lib.strings.splitString "/" s)) 
      ) 
      secrets
    )
  );

  secret_environment = builtins.listToAttrs (builtins.map (s: 
    {
      name = (to_var s);
      value = config.sops.secrets.${to_sops s}.path;
    }
  ) secrets);

  secret_sops = builtins.listToAttrs (builtins.map (s: 
    {
      name = to_sops s;
      value = {};
    }
  ) secrets);

in {
  systemd.services.homepage-dashboard.environment = secret_environment;
  sops.secrets = secret_sops;

  services.homepage-dashboard = {
    # https://gethomepage.dev/

    enable = true;
    package = pkgs-unstable.homepage-dashboard;
    listenPort = 8085;
    allowedHosts = "main.home,127.0.0.1:8084";

    settings = {
      title = "Stroby's Home Server";
      background = {
        image = "/home/stroby/nixos/wallpapers/others/horizon-zero-dawn-aloy-scenery-game-art-landscape-5k-4480x2520-4414.jpg";
        #blur = "sm";
      };
      cardBlur = "xs";
      theme = "dark";
      color = "slate";
    };

    bookmarks = [];

    services = [
      {
        Media = [
          {
            Jellyfin = {
              href = "http://media.home/";
              description = "Media Server";
              icon = "https://jellyfin.org/images/favicon.ico";
              widget = {
                type = "jellyfin";
                url = "http://media.home/";
                key = "{{${secret_vars.jellyfin.key}}}";
                enableBlocks = true;
                enableNowPlaying = true;
                enableUser = true;
                enableMediaControl = true;
                showEpisodeNumber = true;
                expandOneStreamToTwoRows = true;
              };
            };
          }
          {
            Qbittorrent = {
              href = "http://qbittorrent.home/";
              description = "Torrent Downloader";
              icon = "https://www.qbittorrent.org/favicon.svg";
              widget = {
                type = "qbittorrent";
                url = "http://qbittorrent.home/";
                username = "{{${secret_vars.qbittorrent.username}}}";
                password = "{{${secret_vars.qbittorrent.password}}}";
                enableLeechProgress = true;
              };
            };
          }
          {
            Prowlarr = {
              href = "http://prowlarr.home/";
              description = "Indexer Manager";
              icon = "https://prowlarr.com/logo/128.png";
              widget = {
                type = "prowlarr";
                url = "http://prowlarr.home/";
                key = "{{${secret_vars.prowlarr.key}}}";
              };
            };
          }
          {
            Sonarr = {
              href = "http://sonarr.home/";
              description = "Show Search Engine";
              icon = "https://sonarr.tv/img/logo.png";
              widget = {
                type = "sonarr";
                url = "http://sonarr.home/";
                key = "{{${secret_vars.sonarr.key}}}";
              };
            };
          }
          {
            Radarr = {
              href = "http://radarr.home/";
              description = "Movie Search Engine";
              icon = "https://radarr.video/img/logo.png";
              widget = {
                type = "radarr";
                url = "http://radarr.home/";
                key = "{{${secret_vars.radarr.key}}}";
                enableQueue = true;
              };
            };
          }
          {
            Lidarr = {
              href = "http://lidarr.home/";
              description = "Music Search Engine";
              icon = "https://lidarr.audio/img/logo.png";
              widget = {
                type = "lidarr";
                url = "http://lidarr.home/";
                key = "{{${secret_vars.lidarr.key}}}";
              };
            };
          }
        ];
      }
      {
        Data = [
          {
            HomeAssistant = {
              href = "http://home.home/";
              description = "Smart Home";
              icon = "https://upload.wikimedia.org/wikipedia/commons/a/ab/New_Home_Assistant_logo.svg";
              widget = {
                type = "homeassistant";
                url = "http://home.home/";
                key = "{{${secret_vars.home_assistant.key}}}";
                custom = [
                  {
                    state = "sensor.plug_asus_energy_total";
                    label = "Server usage total";
                  }
                  {
                    state = "sensor.plug_asus_energy_today";
                    label = "Server usage today";
                  }
                ];
              };
            };
          }
          {
            Notes = {
              href = "http://notes.home";
              icon = "https://obsidian.md/favicon.svg";
            };
          }
          {
            FileBrowser = {
              href = "https://files.stroby.ipv64.de";
              icon = "https://filebrowser.org/static/logo.png";
            };
          }
          {
            Syncthing = {
              href = "http://syncthing.home/";
              icon = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/Syncthing_Logo.svg/2048px-Syncthing_Logo.svg.png";
            };
          }
          {
            VSCode = {
              href = "http://code.home/?tkn=voZ2d5c7o7lJ6l4C7FDqoaOcWVo2QGzvyf6&folder=/home/stroby/dev";
              icon = "https://code.visualstudio.com/assets/favicon.ico";
            };
          }
          {
            Gallery = {
              href = "http://gallery.home/";
            };
          }
        ];
      }
    ];

    widgets = [
      {
        datetime = {
          text_size = "xl";
          format = {
            timeStyle = "short";
            hourCycle = "h23";
          };
        };
      }
      {
        resources = {
          cpu = true;
          cputemp = true;
          units = "metric";
          memory = true;
          network = true;
          disk = "/";
        };
      }
    ];

    kubernetes = { };

    docker = { };

    customJS = "";
    customCSS = "";
  };

  services.nginx.virtualHosts = {
    "main.${local_domain}" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8085/"; 
      };

      serverAliases = [
        "www.main.${local_domain}"
      ];
    };
  };
}
