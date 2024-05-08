{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnupg
    github-cli
    lazygit
    asdf-vm
    vscode
    azure-cli
    sshpass
    dotnet-sdk_8
    powershell
    mtr-gui
    jdk22
  ];
}
