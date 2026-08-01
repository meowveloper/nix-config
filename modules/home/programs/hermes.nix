{ inputs, pkgs, ... }:
# Hermes Agent (Nous Research) — DISABLED pending upstream fix.
#
# Both the `desktop` Electron package AND the `default` CLI package are
# currently BROKEN upstream in the Nix flake (verified at revs 40e0e7ad
# and 84952e89): the offline `npm install` for the renderer/tui fails with
# ENOTCACHED for `@nous-research/ui` because the root package-lock.json
# carries two versions of that package (0.16.0 at root with integrity,
# 0.18.2 under web/ WITHOUT a `resolved` URL), which upstream's
# importNpmLock pipeline cannot materialize. Not fixable via override.
#
# To re-enable once upstream fixes the flake, uncomment below:
# {
#   home.packages = [
#     inputs.hermes-agent.packages.${pkgs.system}.default
#   ];
# }
{
  home.packages = [ ];
}

