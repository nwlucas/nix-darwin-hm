{
  description = "NWL NixOS ❄ / MacOS 🍏 Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # nix-darwin
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Home manager
    hm.url = "github:nix-community/home-manager";
    hm.inputs.nixpkgs.follows = "nixpkgs-unstable";

    hardware.url = "github:NixOS/nixos-hardware";

    persistence.url = "github:nix-community/impermanence";

    flake-parts.url = "github:hercules-ci/flake-parts";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    nixos-flake.url = "github:srid/nixos-flake";

    nix-index.url = "github:nix-community/nix-index-database";
    nix-index.inputs.nixpkgs.follows = "nixpkgs-unstable";

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    vscode-extensions.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Devshell
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs@{ self, hardware, ... }:
    let
      inherit (inputs.flake-parts.lib) mkFlake;
      inherit (inputs.nixpkgs-unstable.lib.filesystem) listFilesRecursive;
      inherit (inputs.nixpkgs-unstable.lib) listToAttrs hasSuffix hasPrefix removeSuffix removePrefix;
      PROJECT_ROOT = builtins.toString ./.;

      nixosConfig = {
        system = "x86_64-linux";

        specialArgs = {
          inherit hardware;
        };

        modules = [
          inputs.persistence.nixosModule
          inputs.hm.nixosModules.home-manager
          ./system/nixos
        ];
      };

      armNixosConfig = {
        system = "aarch64-linux";
        channelName = "nixpkgs";

        specialArgs = {
          inherit hardware;
        };

        modules = [
          inputs.persistence.nixosModule
          inputs.hm.nixosModules.home-manager
          ./system/nixos
        ];
      };

      darwinMConfig = {
        system = "aarch64-darwin";
        output = "darwinConfigurations";
        builder = inputs.darwin.lib.darwinSystem;

        modules = [
          inputs.hm.darwinModules.home-manager
          ./system/darwin
        ];
      };

      darwinConfig = {
        system = "x86_64-darwin";
        output = "darwinConfigurations";
        builder = inputs.darwin.lib.darwinSystem;

        modules = [
          inputs.hm.darwinModules.home-manager
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
    mkFlake { inherit self inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.nixos-flake.flakeModule
      ];

      perSystem = { self', pkgs, lib, config, ... }: {

        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.nixpkgs-fmt.enable = true;
        };
        formatter = config.treefmt.build.wrapper;

        packages.default = self'.packages.activate;
        devShells.default = pkgs.mkShell {
          inputsFrom = [ config.treefmt.build.devShell ];
          packages = with pkgs; [
            just
            colmena
          ];
        };
      };
    };
  # let
  #   inherit (utils.lib) mkFlake;
  #   inherit (nixpkgs-unstable.lib.filesystem) listFilesRecursive;
  #   inherit (nixpkgs-unstable.lib) listToAttrs hasSuffix hasPrefix removeSuffix removePrefix;
  #   PROJECT_ROOT = builtins.toString ./.;

  #   nixosConfig = {
  #     system = "x86_64-linux";

  #     specialArgs = {
  #       inherit hardware;
  #     };

  #     modules = [
  #       persistence.nixosModule
  #       hm.nixosModules.home-manager
  #       ./system/nixos
  #     ];
  #   };

  #   armNixosConfig = {
  #     system = "aarch64-linux";
  #     channelName = "nixpkgs";

  #     specialArgs = {
  #       inherit hardware;
  #     };

  #     modules = [
  #       persistence.nixosModule
  #       hm.nixosModules.home-manager
  #       ./system/nixos
  #     ];
  #   };

  #   darwinMConfig = {
  #     system = "aarch64-darwin";
  #     output = "darwinConfigurations";
  #     builder = darwin.lib.darwinSystem;

  #     modules = [
  #       hm.darwinModules.home-manager
  #       ./system/darwin
  #     ];
  #   };

  #   darwinConfig = {
  #     system = "x86_64-darwin";
  #     output = "darwinConfigurations";
  #     builder = darwin.lib.darwinSystem;

  #     modules = [
  #       hm.darwinModules.home-manager
  #       ./system/darwin
  #     ];
  #   };

  #   mkHosts = dir:
  #     let
  #       platform =
  #         if hasSuffix "darwinM" dir then
  #           darwinMConfig
  #         else if hasSuffix "darwin" dir then
  #           darwinConfig
  #         else if hasSuffix "arm" dir then
  #           armNixosConfig
  #         else
  #           nixosConfig;
  #     in
  #       listToAttrs (map
  #         (host:
  #           {
  #             name = removeSuffix ".nix" (baseNameOf host);
  #             value = platform // {
  #               modules = platform.modules ++ [ host ];
  #             };
  #           }
  #         )
  #         (listFilesRecursive dir));

  # in
  # mkFlake {
  #   inherit self inputs;

  #   channelsConfig = {
  #     allowUnfree = true;
  #   };

  #   channels = {
  #     nixpkgs = {};
  #     nixpkgs-unstable = {};
  #   };

  #   sharedOverlays = [
  #     vscode-extensions.overlays.default
  #   ];

  #   hostDefaults = {
  #     channelName = "nixpkgs-unstable";
  #     modules = [ ./system ];

  #     extraArgs = {
  #       user = "nwilliams-lucas";
  #       theme = "catppuccin";
  #       version = "23.11";
  #       PROJECT_ROOT = PROJECT_ROOT;
  #     };
  #   };

  #   hosts =
  #     (mkHosts ./hosts/nixos) //
  #     (mkHosts ./hosts/nixos-arm) //
  #     (mkHosts ./hosts/darwinM) //
  #     (mkHosts ./hosts/darwin);
  # };
}
