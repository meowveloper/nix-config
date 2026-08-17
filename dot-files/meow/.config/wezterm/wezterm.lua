-- WezTerm configuration
-- Primary purpose: correct Burmese (Myanmar) font rendering and typing.
-- Typing relies on fcitx5 (system-wide, configured in modules/system/locale.nix
-- and modules/system/burmese.nix). Fonts: Fira Code (Latin) + Padauk (Burmese),
-- mirroring the Neovide setup (dot-files/programs/.config/neovide/config.toml).

local wezterm = require("wezterm")

local config = {}

-- Fonts -------------------------------------------------------------------
-- Padauk (sil-padauk) and Noto Sans Myanmar are installed system-wide via
-- fonts.packages in the Nix config; this is a fontconfig-level fallback list.
config.font = wezterm.font_with_fallback({
    "Fira Code",
    "Padauk",
    "Noto Sans Myanmar",
    "Noto Sans",
})

config.font_size = 11.0 -- matches Ghostty / Neovide (11)
-- Extra line height so tall Burmese tone marks and stacked consonants
-- don't collide with the line above.
config.line_height = 1.2

-- Burmese text is sometimes sent in decomposed (NFD) form; normalize terminal
-- output to NFC so combining marks cluster correctly before HarfBuzz shaping.
config.normalize_output_to_unicode_nfc = true

-- Keep fallback fonts at natural size. Enabling this would try to match the
-- primary font's capital height, but Padauk has no Latin capHeight — leave off.
config.use_cap_height_to_scale_fallback_fonts = false

-- When several fallback fonts can cover the missing glyphs, pick the one with
-- the most coverage (helps ensure Padauk wins for Burmese runs).
config.sort_fallback_fonts_by_coverage = true

-- Shaping: HarfBuzz (the default) already includes the Myanmar script rules,
-- so no change is needed here.
-- config.font_shaper = "Harfbuzz"

-- Input method -------------------------------------------------------------
-- On Wayland, WezTerm talks to fcitx5 via the text-input-v3 protocol when the
-- compositor exposes it. If MangoWM doesn't, WezTerm falls back to plain key
-- events — you may then need XWayland + XIM (see `xim_im_name` in the docs).
config.use_ime = true

-- Appearance ---------------------------------------------------------------
config.window_background_opacity = 0.7
config.window_padding = { left = 20, right = 20, top = 10, bottom = 10 }
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 10000

-- No "noctalia" scheme is bundled with WezTerm; uncomment one you like:
-- config.color_scheme = "Catppuccin Mocha"

-- Tmux-style keybindings (mirrors Ghostty's ctrl+s prefix, which mirrors
-- programs.tmux.shortcut = "s")
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
    -- Tabs
    { key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
    { key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
    { key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
    { key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
    { key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
    { key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
    { key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
    { key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
    { key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },
    -- Pane navigation (matching ghostty's ctrl+s>h/j/k/l)
    { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
    -- Splits
    { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
}

return config
