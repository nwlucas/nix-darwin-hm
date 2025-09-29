{ pkgs, ... }:

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
    nixd
  ];

  homebrew = {
    brews = [
      "k9s"
      "Azure/kubelogin/kubelogin"
      "opentofu"
      "pgroll"
      "derailed/k9s/k9s"
      "python3"
      "pipx"
      "ansible"
      "ansible-lint"
      "doctl"
      "kubectl"
      "helm"
    ];
    casks = [
      "jetbrains-toolbox"
      "postman"
      "sublime-text"
      "temurin"
      "temurin@20"
      "iterm2"
      "zed"
    ];
    taps = [
      "xataio/pgroll"
      "derailed/k9s"
      "Azure/kubelogin"
    ];
  };
}
