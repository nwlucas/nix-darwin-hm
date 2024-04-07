{ user, pkgs, ... }:

{
    users.users.nixos = {
      useDefaultShell = true;
      isNormalUser = true;
      description = "NixOS default user";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAUf2GYFarEpC8HsV6964tE6xU2zIh5MfwVvXxkq3AUf"
      ];
    };
    users.users.${user} = {
      useDefaultShell = true;
      isNormalUser = true;
      description = user;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAUf2GYFarEpC8HsV6964tE6xU2zIh5MfwVvXxkq3AUf"
      ];
    };
}
