{ lib, pkgs, ... }:

{
  imports = [
    ./bat
    ./git
    ./starship

    ./atuin.nix
    ./fzf.nix
    ./gh.nix
    ./jq.nix
    ./neovim.nix
    ./nix-index.nix
    ./terraform.nix
    ./zoxide.nix
  ];
}
