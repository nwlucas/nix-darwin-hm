{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #wezterm
    # Utils
    act
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
    rustup
    direnv
    starship
    nerdfonts
    atuin
    nodejs_22
    corepack_latest
    p7zip.out
    libisoburn
    cloc
    iterm2
  ];
}
