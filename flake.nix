{
  description = "NWL NixOS ❄ / MacOS 🍏 Configuration";

  inputs = {
    # Nixpkgs
    stable.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # nix-darwin
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "unstable";

    # Home manager
    hm.url = "github:nix-community/home-manager/master";
    hm.inputs.nixpkgs.follows = "unstable";

    hm-stable.url = "github:nix-community/home-manager/release-23.11";
    hm-stable.inputs.nixpkgs.follows = "stable";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "stable";

    hardware.url = "github:NixOS/nixos-hardware/master";

    persistence.url = "github:nix-community/impermanence";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    nix-index.url = "github:Mic92/nix-index-database";
    nix-index.inputs.nixpkgs.follows = "unstable";

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    vscode-extensions.inputs.nixpkgs.follows = "unstable";

  };

  outputs = {
    self,
    stable,
    unstable,
    darwin,
    hm,
    hm-stable,
    hardware,
    persistence,
    vscode-extensions,
    utils,
    sops-nix,
    ... } @ inputs:
  let
    inherit (utils.lib) mkFlake;
    inherit (unstable.lib.filesystem) listFilesRecursive;
    inherit (unstable.lib) listToAttrs hasSuffix hasPrefix removeSuffix removePrefix;
    PROJECT_ROOT = builtins.toString ./.;

    nixosConfig = {
      system = "x86_64-linux";

      specialArgs = {
        inherit hardware;
      };

      modules = [
        persistence.nixosModule
        hm.nixosModules.home-manager
        sops-nix.nixosModules.sops
        ./system/nixos
      ];
    };

    armNixosConfig = {
      system = "aarch64-linux";
      channelName = "stable";

      specialArgs = {
        inherit hardware;
      };

      modules = [
        persistence.nixosModule
        hm.nixosModules.home-manager
        sops-nix.nixosModules.sops
        ./system/nixos
      ];
    };

    darwinMConfig = {
      system = "aarch64-darwin";
      output = "darwinConfigurations";
      builder = darwin.lib.darwinSystem;

      modules = [
        hm.darwinModules.home-manager
        ./system/darwin
      ];
    };

    darwinConfig = {
      system = "x86_64-darwin";
      output = "darwinConfigurations";
      builder = darwin.lib.darwinSystem;

      modules = [
        hm.darwinModules.home-manager
        ./system/darwin
      ];
    };

    mkHosts = dir:
      let
        platform =
          if hasSuffix "darwinM" dir then
            darwinMConfig
          else if hasSuffix "darwin" dir then
            darwinConfig
          else if hasSuffix "arm" dir then
            armNixosConfig
          else
            nixosConfig;
      in
        listToAttrs (map
          (host:
            {
              name = removeSuffix ".nix" (baseNameOf host);
              value = platform // {
                modules = platform.modules ++ [ host ];
              };
            }
          )
          (listFilesRecursive dir));

  in
  mkFlake {
    inherit self inputs;

    channelsConfig = {
      allowUnfree = true;
    };

    channels = {
      stable = {};
      unstable = {};
    };

    sharedOverlays = [
      vscode-extensions.overlays.default
    ];

    hostDefaults = {
      channelName = "unstable";
      modules = [ ./system ];

      extraArgs = {
        user = "nwilliams-lucas";
        theme = "catppuccin";
        version = "23.11";
        PROJECT_ROOT = PROJECT_ROOT;
      };
    };

    hosts =
      (mkHosts ./hosts/nixos) //
      (mkHosts ./hosts/nixos-arm) //
      (mkHosts ./hosts/darwinM) //
      (mkHosts ./hosts/darwin);
  };
}
