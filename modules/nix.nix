{ inputs, lib, ... }:
{
  nix.registry.nixpkgs.to = {
    type = "path";
    path = lib.mkForce inputs.nixpkgs-stable.outPath;
  };
}
