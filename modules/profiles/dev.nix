{
  pkgs,
  lib,
  config,
  ...
}:

{
  config = lib.mkIf config.d.profiles.dev.enable {
    environment.systemPackages = with pkgs; [
      github-cli
      lazygit
      asdf-vm
      vscode
      azure-cli
      dotnet-sdk_8
      powershell
      kdoctor
      nixd
    ];

    homebrew = {
      brews = [
        "k9s"
        "Azure/kubelogin/kubelogin"
        "opentofu"
        "derailed/k9s/k9s"
        "python3"
        "pipx"
        "doctl"
        "kubectl"
        "helm"
        "gemini-cli"
      ];
      casks = [
        "temurin@20"
        "claude-code"
      ];
      taps = [
        "derailed/k9s"
        "Azure/kubelogin"
      ];
    };
  };
}
