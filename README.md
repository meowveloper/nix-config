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
`user-settings.nix` is gitignored, so it must be created by hand on every
machine. A tracked template is available:

```bash
cp user-settings.example.nix user-settings.nix
```

## machine settings (step by step)

On every new machine you must create `machine-settings.nix` before the flake will evaluate. Here is exactly how:

1. **Create the file from the template:**
   ```bash
   cp machine-settings.example.nix machine-settings.nix
   ```

2. **Open it in your editor** and fill the fields below.

3. **Find your disk (the extra volume):**
   ```bash
   lsblk -f
   ```
   Example output:
   ```
   NAME   FSTYPE LABEL UUID
   sdb    ext4         1ed14588-7c5b-4f65-98cc-0f3a746ea157
   ```
   - **copy** the `UUID` column value (e.g. `1ed14588-...`) → **paste** as:
     `extraVolumeDevice = "/dev/disk/by-uuid/1ed14588-7c5b-4f65-98cc-0f3a746ea157";`
   - **copy** the `FSTYPE` column value (e.g. `ext4`) → **paste** as:
     `extraVolumeFsType = "ext4";`
   - If you don't need an extra data disk, comment out both lines.

4. **Find your GPU (NVIDIA laptop):**
   ```bash
   nix shell nixpkgs#pciutils -c lspci | grep -i -e vga -e 3d
   ```
   (`lspci` is not installed by default — the `nix shell` one-liner runs it temporarily without changing your system.)
   Example output:
   ```
   00:02.0 VGA compatible controller: Intel Corporation ...
   01:00.0 VGA compatible controller: NVIDIA Corporation ...
   ```
   - **copy** the Intel address `00:02.0`, convert dots→colons and drop leading zeros → `PCI:0:2:0` → **paste** as `gpu.intelBusId`
   - **copy** the NVIDIA address `01:00.0` → `PCI:1:0:0` → **paste** as `gpu.nvidiaBusId`
   - **No NVIDIA GPU?** set `gpu.enable = false;` and skip the next step.
   - Tip: `nvidia-smi` already shows the NVIDIA address in its `Bus-Id` column (e.g. `00000000:01:00.0` → `PCI:1:0:0`). You still need `lspci` for the Intel iGPU address.

5. **Pick the NVIDIA driver:**
   ```bash
   nvidia-smi
   ```
   - **copy** your GPU's supported branch → **paste** as `gpu.driver` (e.g. `"latest"`, `"stable"`, or `"legacy_580"` for older GPUs).

6. **Set the hostname** — type any name you like as `hostName = "your-hostname";`.

7. **`maxJobs` / `cores`** are optional build caps. Leave the defaults if unsure; lower them on weak/throttled machines.

8. **Rebuild:**
   ```bash
   sudo nixos-rebuild switch --flake "path:$(pwd)#nixos"
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
