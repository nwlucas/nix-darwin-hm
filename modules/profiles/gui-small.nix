{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mtr-gui
  ];

  homebrew = {
    casks = [
      "iterm2"
      "sublime-text"
    ];
  };
}
