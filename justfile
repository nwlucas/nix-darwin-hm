default:
    @just --list

fmt:
    treefmt

# Fetch SSH keys from 1Password. Run after darwin-rebuild switch on a fresh
# machine once 1Password is installed, unlocked, and CLI integration is enabled
# (1Password Settings → Developer → Integrate with 1Password CLI).
fetch-ssh-keys:
    op --account="dtlrinc.1password.com" read "op://Employee/3hef3bpdxdt4bdl5ptkm5d3jou/private key" > ~/.ssh/gitlab-work-gl && chmod 600 ~/.ssh/gitlab-work-gl && echo "GitLab SSH key placed at ~/.ssh/gitlab-work-gl"
