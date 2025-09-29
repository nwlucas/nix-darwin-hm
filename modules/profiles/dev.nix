{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    github-cli
    lazygit
    asdf-vm
    vscode
    azure-cli
    dotnet-sdk_8
    powershell
    kdoctor
  ];
}

