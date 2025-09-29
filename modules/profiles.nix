{ config, lib, ... }:

let
  cfg = config.d.profiles;

  mkBool =
    default:
    lib.mkOption {
      type = lib.types.bool;
      default = default;
    };
in

{
  # Profiles group related modules under a single flag for convenience.
  #
  # Notes:
  # - Not every module is profiled. By design.
  # - Individual modules can still be toggled independently.
  options.d.profiles = {
    # For: core configurations and programs e.g. system pkgs, fonts,
    # browsers, editors, terminal ..etc.
    base.enable = mkBool true;

    # For: Minimal GUI applications
    gui-small.enable = mkBool false;

    # For: Full GUI applications
    gui-full.enable = mkBool false;

    # For: Developers. Developers. Developers :)
    dev = {
      enable = mkBool true;

      js.enable = mkBool cfg.dev.enable;

      # Per machine
      go.enable = mkBool false;
      py.enable = mkBool false;
      rust.enable = mkBool false;
    };

    # For: Corporate programs e.g. Zoom, Slack, etc.
    business.enable = mkBool false;

    # For: Gaming related programs e.g. Steam
    gaming.enable = mkBool false;
  };

  # config = {
  imports = [
    (lib.mkIf cfg.base.enable ./profiles/base.nix)
    (lib.mkIf cfg.dev.enable ./profiles/dev.nix)
    (lib.mkIf cfg.gui-small.enable ./profiles/gui-small.nix)
    (lib.mkIf cfg.gui-full.enable ./profiles/gui-full.nix)
    (lib.mkIf cfg.business.enable ./profiles/business.nix)
    (lib.mkIf cfg.gaming.enable ./profiles/gaming.nix)
  ];
  # };
}
