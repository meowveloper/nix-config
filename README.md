# ❄️ NixOS Configuration
- MangoWM
- NoctaliaShell
- Ghostty
- Neovim

## user settings
create `user-settings.nix` in repo root with the following format
```nix
{
    username1 = "user-1"; # Change this to your real primary user
    username2 = "user-2";       # Change this to your secondary user
    dotfiles_path = "/path/to/dotfiles/in/nix-config/directory";
    shared_path = "/path/to/a/shared/dir/between/two/users";
}
```

## how to run rebuild command when absolute path
> so that user-settings.nix get read when rebuilding

```bash
sudo nixos-rebuild switch --flake "path:/absolute/path/to/nix-config"
```
or

```bash
sudo nixos-rebuild switch --flake "path:/absolute/path/to/nix-config#your-hostname"
```
