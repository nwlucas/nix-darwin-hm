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
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
