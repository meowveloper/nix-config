{
  # USER SETTINGS (EXAMPLE TEMPLATE)
  # --------------------------------
  # This file is a tracked template mirroring the schema of the real,
  # gitignored `user-settings.nix`. To use it on a new machine:
  #
  #     cp user-settings.example.nix user-settings.nix
  #
  # Then replace every placeholder below (e.g. <username>, <path>).
  # `user-settings.nix` MUST exist before the flake can evaluate —
  # it is imported in `flake.nix` and passed to every module as `userSettings`.

  username1 = "<username>";      # Change this to your real primary user
  username2 = "<username>";      # Change this to your secondary user
  dotfiles_path = "<path>";      # Absolute path to the dot-files dir inside this nix-config
  shared_path = "<path>";        # Absolute path to a shared dir between the two users
}