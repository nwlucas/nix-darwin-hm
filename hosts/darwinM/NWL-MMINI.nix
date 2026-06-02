{ pkgs, user, ... }:
let
  homePrefix = if pkgs.stdenv.isDarwin then "/Users" else "/home";
in
{
  config = {
    d.profiles = {
      base.enable = true;
      dev.enable = true;
      gui-small.enable = true;
      gui-full.enable = true;
      business.enable = true;
      gaming.enable = false;
    };

    ids.gids.nixbld = 350;
    system.primaryUser = user;

    home-manager = {
      users.${user} = {
        home = { };

        programs = { };

        op-secrets = {
          enable = true;
          account = "my.1password.com";
          # serviceAccountTokenFile = "/Users/${user}/.config/personal/1penv";
          secrets = {
            op-connect-env = {
              template = ../secrets/op-connect.tpl;
              dest     = "/Users/${user}/projects/personal/.op-connect";
              mode     = "0600";
            };
            # example-secret = {
            #   type   = "sshKey";
            #   source = "op://Vault/ItemID";
            #   dest   = "/Users/${user}/.ssh/example-key";
            #   writePublicKey = true;
            # };
            # example-env = {
            #   template = ../secrets/example.tpl;
            #   dest     = "/Users/${user}/projects/example/.env";
            #   mode     = "0600";
            # };
            #
            # Full template example — multi-row key=value / dotenv file:
            #
            #   # In NWL-MMINI.nix:
            #   app-env = {
            #     template = ../secrets/app.env.tpl;
            #     dest     = "/Users/${user}/projects/myapp/.env";
            #     mode     = "0600";
            #   };
            #
            #   # In home/secrets/app.env.tpl:
            #   DATABASE_URL=postgres://app:{{ op://Dev/myapp-db/password }}@localhost/myapp
            #   REDIS_PASSWORD={{ op://Dev/myapp-redis/password }}
            #   STRIPE_SECRET_KEY={{ op://Dev/myapp-stripe/api key }}
            #   GITHUB_TOKEN={{ op://Dev/myapp-github/token }}
            #
            # `op inject` replaces each {{ op://... }} with the real value at activation time.
            # The template itself is world-readable in the Nix store — only op:// refs, never
            # literal secrets. Each row becomes a resolved KEY=value line in the output file.
          };
        };
      };
    };
  };
}
