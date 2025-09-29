{
  nix = {
    enable = false;
    # settings = {
    #   trusted-users = [ "root" "@wheel" ];
    # };

    # optimise = {
    #   automatic = false;
    # };

    # gc = {
    #   automatic = true;
    #   options = "--delete-older-than 10d";
    # };

    # package = pkgs.nixVersions.latest;
    # registry.nixpkgs.flake = lib.mkDefault inputs.nixpkgs-stable;

    # extraOptions = ''
    #   experimental-features = nix-command flakes
    #   warn-dirty = false
    # '';
  };
}
