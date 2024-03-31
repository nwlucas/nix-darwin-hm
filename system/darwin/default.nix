{ pkgs, user, ... }:
let
  # https://brew.sh
  initBrew = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
in
{
  imports = [
    # ./yabai
    ./dock.nix
    ./finder.nix
    ./keyboard.nix
    ./login.nix
    ./brew.nix
    # ./safari.nix
    ./trackpad.nix
  ];

  system.stateVersion = 4;
  system.activationScripts.postUserActivation.text = ''
  # activateSettings -u will reload the settings from the database and apply them to the current session,
  # so we do not need to logout and login again to make the changes take effect.
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
'';

  # User that runs the garbage collector.
  nix.gc.user = user;
  services.nix-daemon = {
    enable = true;
  };

  d.hm = [
    { imports = [ ./hm ]; }
  ];

  programs.zsh.interactiveShellInit = ''
    # Homebrew
    if test -e /opt/homebrew/bin/brew;
      ${initBrew};
    end
  '';

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    AppleMeasurementUnits = "Inches";
    AppleTemperatureUnit = "Fahrenheit";
  };
}