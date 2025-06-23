{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    #wezterm
    # Utils
    act
    cmake
    coreutils
    curl
    fzf
    gnumake
    httpie
    killall
    lsof
    neofetch
    ripgrep
    unzip
    bat
    vim
    zoxide
    jq
    yq-go
    btop
    cheat
    just
    rustup
    direnv
    starship
    atuin
    p7zip.out
    libisoburn
    sops
    age
    ssh-to-age
    nixd
    biome
    tree
    nixfmt-rfc-style
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
