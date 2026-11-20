{ ... }: {
    # Cloudflare WARP (1.1.1.1) — free, unlimited, hides traffic from the ISP.
    # No account needed. Provides: warp-cli in PATH, warp-svc daemon, UDP 2408 open.
    services.cloudflare-warp.enable = true;
}
