{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnupg
    github-cli
    lazygit
    asdf-vm
    vscode
    azure-cli
  ];
}
