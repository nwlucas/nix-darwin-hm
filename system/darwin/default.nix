{ pkgs, user, PROJECT_ROOT, ... }:
let
  # https://brew.sh
  initBrew = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
in
{
  imports = [
    # ./yabai
    ./general.nix
    ./dock.nix
    ./finder.nix
    ./keyboard.nix
    ./login.nix
    ./brew.nix
    ./fonts.nix
    ./packages.nix
    # ./safari.nix
    ./trackpad.nix
  ];

  system.stateVersion = 4;
  system.activationScripts.postUserActivation.text = ''
    # activateSettings -u will reload the settings from the database and apply them to the current session,
    # so we do not need to logout and login again to make the changes take effect.
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  nix.linkInputs = true;
  nix.generateRegistryFromInputs = true;
  nix.generateNixPathFromInputs = true;

  d.hm = [
    { imports = [ ./shells.nix ]; }
  ];

  programs.zsh.interactiveShellInit = ''
    # Homebrew
    if test -e /opt/homebrew/bin/brew;
      ${initBrew};
    end
  '';

  security.pam.services.sudo_local.touchIdAuth = true;
  security.pki.installCACerts = true;
  security.pki.certificateFiles = [
    "${PROJECT_ROOT}/files/certs/certificate.pem"
  ];

  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    AppleMeasurementUnits = "Inches";
    AppleTemperatureUnit = "Fahrenheit";
  };
}
