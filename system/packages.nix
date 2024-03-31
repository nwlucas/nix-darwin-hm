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
    gnupg
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
    github-cli
    lazygit
    yq-go
    neovim
    btop
    cheat
    just
    direnv
    starship
    atuin
    asdf-vm
  ];
}
