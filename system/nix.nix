{ pkgs, inputs, ... }:

{
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
    };

    optimise = {
      automatic = true;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };

    package = pkgs.nixVersions.stable;
    registry.nixpkgs.flake = inputs.nixpkgs;

    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
  };
}
