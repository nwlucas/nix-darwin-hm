channels: final: prev: {
  __dontExport = true;

  inherit (channels.nixpkgs-stable)

    # NixOS
    nix-ld

    # Terminal
    wezterm
    ;
}
