{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wezterm

    # Utils
    cmake
    coreutils
    curl
    fzf
    git
    gnumake
    httpie
    killall
    lsof
    neofetch
    ripgrep
    unzip
    eza
    bat
    vim
    zoxide
    jq
    yq-go
    neovim
    btop
    cheat
    just
    direnv
    starship
    atuin
    nodejs_20
    corepack_latest
    p7zip.out
    libisoburn
    cloc
    python312Packages.python
  ];
}
