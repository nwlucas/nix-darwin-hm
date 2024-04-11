{ pkgs, inputs, ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };

    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs-unstable;

    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
  };
}
