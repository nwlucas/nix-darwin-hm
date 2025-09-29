{
  ...
}:

# let
#   pkgs-unstable = import inputs.nixpkgs {
#     inherit (pkgs) system;
#     config.allowUnfree = true;
#   };
# in

{
  environment.systemPackages = [ ];
}
