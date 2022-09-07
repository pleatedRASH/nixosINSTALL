# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: 

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      	
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
#    keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    videoDrivers = [ "intel" ];
    libinput.enable = true;
    layout = "us";
    displayManager = {
      defaultSession = "none+herbstluftwm";
    };
  };

  services.xserver.windowManager.herbstluftwm.enable = true;
  
  # BLUETOOTH 
  services.blueman.enable = true;


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
#    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };

  hardware.bluetooth.settings = {
    
    General = {
      Enable = "Sourcec,Sink,Media,Socket";
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cuckboi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "video" "sound" "storage" ]; # Enable ‘sudo’ for the user.
    createHome = true;
    home = "/home/cuckboi";
    shell = "/run/current-system/sw/bin/fish";

  };  
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
    binutils
    pciutils
    coreutils
    feh
    dmenu
    herbstluftwm
    i3
    cwm
    tcsh
    nano 
    sudo
    fish
    
    vscodium
    networkmanager
    rxvt-unicode
    firefox
    gcc
    cmake
    htop
    wirelesstools
    ffmpeg
    vlc
  ];
  

  # NIXPKGS
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystems = true;
  };

  # FONTS
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      inconsolata
      fira-mono
      source-code-pro
      jetbrains-mono
    ];
  };


  # PROGRAMS
  programs.fish.enable = true;

  

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
