{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        cloudflare-warp
    ];
    services.cloudflare-warp.enable = true;
    services.tailscale.enable = true;
}
