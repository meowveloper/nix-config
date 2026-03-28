-- Neovide specific settings
if vim.g.neovide then
    -- 1. Transparency settings (Double-ensuring they work)
    -- This sets the overall window transparency
    vim.g.neovide_opacity = 0.4
    -- This ensures the main text buffer is also transparent
    vim.g.neovide_normal_opacity = 0.4

    -- 2. Scrolling and UI scaling
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_scroll_animation_length = 0.3

    -- 3. Cursor Aesthetics
    vim.g.neovide_cursor_animation_length = 0.13
    vim.g.neovide_cursor_trail_size = 0.8

    vim.g.neovide_padding_top = 20
    vim.g.neovide_padding_bottom = 5
    vim.g.neovide_padding_right = 5
    vim.g.neovide_padding_left = 10
    vim.g.neovide_scale_factor = 1.0
end
