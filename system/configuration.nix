# Edit this configuration file to define what should be installed on # your system.  Help is available in the configuration.nix(5) man page
## and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:


{

  imports = [
      # ./borgbackupMonitor.nix
      # inputs.xremap-flake.nixosModules.default
      ./hardware-configuration.nix
      ./unstable.nix
      # <home-manager/nixos> # ./borgbackupMonitor.nix #./vim.nix
      # ./notify-service-service.nix
      # ./services.nix
    ];

nix = {
  package = pkgs.nixFlakes;
 extraOptions = "experimental-features = nix-command flakes"; 
};

system = {
  stateVersion = "23.05"; # Did you read the comment?
  autoUpgrade.enable = true;
  autoUpgrade.allowReboot = false;
};
   

boot = { 
  plymouth.enable = true;
  loader.systemd-boot.enable = true;
  loader.efi.canTouchEfiVariables = true;
  supportedFilesystems = [ "ntfs" ];
#Setup keyfile 
  # initrd.secrets = {
  #   "/crypto_keyfile.bin" = null;
  #       };
};

fonts.fonts = with pkgs; [
  font-awesome_5
  nerdfonts
];

networking = {
  # extraHosts = 
  # ''
  #   # 10.133.0.2 vcenter.bletchley.ap.be
  # '';
  hostName = "nixos";
  networkmanager.enable = true;
  nameservers = [ "9.9.9.9" ];
 #wireless.enable = true; # enable wireless support via wpa_supplicant
   # wg-quick.interfaces = { #/
   #   wg0 = { #/
   #     address = [ "10.147.94.120/32" "fd7d:76ee:e68f:a993:68bb:339:f2ff:8a29/128" ]; #/
   #     dns = [ "10.128.0.1" "fd7d:76ee:e68f:a993::1" ]; #/
   #     privateKeyFile = "~/.dotfiles/secrets/wireguard/privatekey"; #/

   #    peers = [ #/
   #       { #/
   #       publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk="; #/
   #       presharedKeyFile = "~/.dotfiles/secrets/wireguard/presharedKeyFile"; #/
   #       allowedIPs = [ "0.0.0.0/0" "::/0" ]; #/
   #       endpoint = "nl.vpn.airdns.org:1637"; #/
   #       persistentKeepalive = 15; #/
   #       } #/
   #     ]; #/
   #   }; #/
   # }; #/
};

time.timeZone = "Europe/Brussels";
console.keyMap = "be-latin1";

  # Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";

users = {
  groups.nixosvmtest = {};
  defaultUserShell = pkgs.fish;
  users = {
    nixosvmtest.group = "nixosvmtest";
    nixosvmtest.isSystemUser = true;
    nixosvmtest.initialPassword = "test";
    reinoud = {
      isNormalUser = true;
        description = "reinoud";
        extraGroups = [ 
          "kvm"
          "networkmanager"
          "wheel"
          "libvirtd"
          "audio"
          "dbus"
          "tss" #tpm
        ];
        packages = with pkgs; [];
    };
  };
}; 

nixpkgs.config.allowUnfree = true;


environment.systemPackages = with pkgs; [



lxappearance # change icon & themes i3
i3
x11basic
xdg-desktop-portal-gnome
i3status
lightdm
i3blocks

# audio
  blueman # bluetooth
  pulseaudioFull
  alsa-utils

# core
jmtpfs # mtp for connection mobile phones
bat
screen
auto-cpufreq
samba4Full
btrfs-progs
bridge-utils
mpv
blugon
unrar-wrapper
dig
#wpa_supplicant_gui
sshfs
psmisc
linuxKernel.packages.linux_zen.cpupower # set cpu performance
  cargo
  tmux
  findutils
  mlocate
  gnome.zenity
  bash
  python3Full
  wireguard-tools

  wget
  zip
  unzip
  htop
  libnotify
  brightnessctl
  playerctl
  git
  cryptsetup
  polkit_gnome
  lsof # volume control²
  dunst
  p7zip
  ntfs3g
  arandr
  android-udev-rules
  ncdu
  podman
  distrobox
  wirelesstools

# gaming
xwiimote
wiiuse
wiiload
dolphin-emu
vulkan-tools
vulkan-loader
steam-run
protontricks
protonup-qt
winetricks
steam
lutris
  #jc141
  perl536Packages.OpenGL
    wineWowPackages.full
    wineWowPackages.unstableFull
    # fuse-overlayfs
	vitetris

# virtual
	virt-manager
  vmware-workstation
  qemu_full

    btop 
    xfce.xfce4-screenshooter
    alacritty
    # unstable.freetube
    # unstable.ciscoPacketTracer8
    libreoffice
    gimp
    youtube-tui
    iamb
    matrixcli
    nheko
    gimp
    russ # rss
    gpicview 
    vlc
    haskellPackages.subnet
    pro-office-calculator
    wcalc
    qbittorrent
    rclone
    feh
	vim-full
  neovim
    xcolor
    xfce.thunar
    thunderbird
    filezilla
    wireshark
    nmap
    pipe-viewer
    dolphin
    spotify
    spotifyd
    spotify-player
    fish
    neofetch
    keepassxc
    signal-desktop
    gparted
    rofi
    rofi-vpn
    rofi-calc
    rofi-power-menu
    vorta
    borgbackup
    electron-mail
    tutanota-desktop
    onlyoffice-bin
    kate
    element-desktop
    lf
# browser
    librewolf
    firefox
    tor-browser-bundle-bin 
    tor
    brave
];


networking.firewall.allowedTCPPorts = [
  8080
];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];

virtualisation = {
  libvirtd.enable = true;
  podman.enable = true;
  vmware.host.enable = true;
};

programs = {
  i3lock.enable = true;
  ssh.knownHosts = {
      myhost = {
        extraHostNames = [ "192.168.0.125" ];
        publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCk74I9ZaUUFUsDhMcZllvsD418Po4d4mR0rTMFVTMhy7kFIUAqcoAUSCnZHO7ROrTAUhmgqlBpwvYFBo9Dpr7Zf8PV2tPu2avw8Gan1pfDE7FTQitVaUqOdtoe+Km+gTdaCZLTg3W+KJ+4+TRg+7PqrYiWwIlAsMUjmWDr4nYArJplqYFTpVuWzLjZmiADW0AD/bJmw0P7+lZmcLrgUkXUoEH12ZOdTp4g+bAe7CSqEK5I3Ao1eWluydk425oBhF2Wd0cVBShnfMN3fdxWm0Bkg/W0daeHM1kZ9cXzZwtcVInJz7NYxnP3iUA4QQ3xL2lCg/ZF0Z+n0QKSH+12AtPCvoOXXIBYqYf0bUt7U9IsTvJ3gmWW2W4yDgVWTHoFGKnkWMXy3svgf0f1+BMv6EE+cQ/O9FehiJwX1YasYISXbAxqgyt2M5lg3QLP7b9tLMgvghSddTg9olZBZ3cgtT9/jEEHiZzGxaGlNmFuLhZoU7RyvzequHfnb5aLqXkDb6c=";
      };
    };
	dconf.enable = true;
	vim.defaultEditor = true;
  fish = {
    enable = true;
    promptInit = "test"; 
    shellInit = "set -U fish_greeting"; # what to launch when terminal started
    loginShellInit = "date";
    # interactiveShellInit = "shuf -n 1 /home/reinoud/scripts/facts";
    interactiveShellInit = "";
    shellAliases = {
      plutomooimaken="sudo nix-collect-garbage --delete-older-than 2d && applysystem";
      ap="cd ~/Documents/ap";
      dot="cd /home/reinoud/.dotfiles/"; 
      applysystem="bash /home/reinoud/.dotfiles/apply-system.sh";
      applyuser="bash /home/reinoud/.dotfiles/apply-users.sh";
    };
  };
  thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin 
      thunar-volman
      thunar-media-tags-plugin 
    ];
  };
};

powerManagement.enable = true;
services = { 
  thermald.enable = true;
  tlp.enable = true;
  auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
      governor = "powersave";
      turbo = "never";
      };
      charger = {
      governor = "performance";
      turbo = "auto";
      };
    };
  borgbackup.jobs.home-dir = {
    exclude = [
      "/home/*/Games" 
      ".cache"
      "*/basestation"
    ];
    patterns = [ # Include/exclude paths matching the given patterns. The first matching patterns is used, so if an include pattern (prefix +) matches before an exclude pattern (prefix -), the file is backed up. See borg help patterns for pattern syntax.
        
    ];
    paths = "/home/";
    encryption = {
      mode = "keyfile";
      passCommand = "cat /config/borg/password";
      };
    environment.BORG_RSH = "ssh -i /home/reinoud/.ssh/id_rsa";
    repo = "ssh://reinoud@192.168.0.125:57130/mnt/2tb/backup/nixos";
    compression = "auto,zstd";
    startAt = "hourly";
    prune.keep = {
      within = "1d";
      daily = 7;
      weekly = 4;
      monthly = 12;
      yearly = 5;
    };
  };    
  dbus.enable = true;
  openssh.enable = true;
	pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true; };
	flatpak.enable = true;
	xserver = { 
		layout = "be";
		xkbVariant = "";
    enable = true;
    windowManager = {
      dwm = {
        enable = true;
      };
      i3 = {
        configFile = /home/reinoud/.config/i3/config;
        enable = true;
      };
		};
  };    
	blueman.enable = true;
  picom.enable = true;
  #thunar related
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
};

systemd.user = {
  timers = {
    battery-alert = {
      enable = true;
      description = "Battery Alert Timer";
      timerConfig = {
        OnActiveSec = "1m";
        OnStartupSec = "1m";
        RemainAfterElapse= true;
        OnUnitActiveSec = "1m";
        Unit = "battery-alert.service";
      };
      wantedBy = [ "default.target" ];
    };
  };
  services = {

    battery-alert = {
      enable = true;
      path = with pkgs; [ bash libnotify ];
      description = "Battery Alert Service";
      serviceConfig = {
        ExecStart = "${pkgs.bash}/bin/bash /home/reinoud/.dotfiles/scripts/battery/alert-battery.sh";
          Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
        Type = "simple";
      };
      wantedBy = ["default.target"]; 
      };

       polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; Restart = "on-failure"; RestartSec = 1; TimeoutStopSec = 10; 
          };
    };
	};
};

 hardware = {
  uinput.enable = true; # iets voor xremap 
  bluetooth.enable = true;
};

nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 15d";
};

specialisation = { 
   nvidia.configuration = { 
     # Nvidia Configuration 
     services.xserver.videoDrivers = [ "nvidia" ]; 
     hardware.opengl.enable = true; 
  
     # Optionally, you may need to select the appropriate driver version for your specific GPU. 
     hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; 
  
     # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway 
     hardware.nvidia.modesetting.enable = true; 
  
     hardware.nvidia.prime = { 
       sync.enable = true; 
  
       # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA 
       nvidiaBusId = "PCI:1:0:0"; 
  
       # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA 
       intelBusId = "PCI:0:2:0"; 
     };
  };
};

security = {
  rtkit.enable = true;
  tpm2 = {
    enable = true;
    pkcs11.enable = true;  # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
    tctiEnvironment.enable = true;  # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
  };
};
}
