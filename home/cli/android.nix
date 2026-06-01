{ pkgs, ... }:

let
  androidHome = if pkgs.stdenv.isDarwin then "$HOME/Library/Android/sdk" else "$HOME/Android/Sdk";
in
{
  home.sessionVariables = {
    ANDROID_HOME = androidHome;
    ANDROID_SDK_ROOT = androidHome; # legacy alias some tools still read
  };

  home.sessionPath = [
    "${androidHome}/platform-tools"
    "${androidHome}/emulator"
    "${androidHome}/cmdline-tools/latest/bin"
  ];
}
