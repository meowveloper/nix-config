local function get_matugen_colors()
    local matugen_path = vim.fn.stdpath("config") .. "/matugen.lua"
    if vim.fn.filereadable(matugen_path) == 1 then
        -- dofile avoids the Lua module cache, ensuring we always get the latest colors
        return dofile(matugen_path)
    end
    return nil
end

local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local function apply_matugen_colors(colors)
    if colors then
        -- Surface / Foreground
        vim.api.nvim_set_hl(0, "Normal", { fg = colors.on_surface, bg = "none" })

        -- Keywords, functions, etc.
        vim.api.nvim_set_hl(0, "Keyword", { fg = colors.primary })
        vim.api.nvim_set_hl(0, "Function", { fg = colors.surface_tint })
        vim.api.nvim_set_hl(0, "String", { fg = colors.tertiary })
        vim.api.nvim_set_hl(0, "Comment", { fg = colors.outline, italic = true })

        -- UI elements
        vim.api.nvim_set_hl(0, "LineNr", { fg = colors.outline_variant })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.primary, bold = true })
        vim.api.nvim_set_hl(0, "Visual", { bg = colors.secondary_container, fg = colors.on_secondary_container })
    end
end

local function get_lualine_theme(colors)
    if not colors then return "tokyonight" end

    return {
        normal = {
            a = { fg = colors.on_primary, bg = colors.primary, gui = 'bold' },
            b = { fg = colors.on_surface_variant, bg = colors.surface_container },
            c = { fg = colors.on_surface, bg = "none" },
        },
        insert = {
            a = { fg = colors.on_secondary, bg = colors.secondary, gui = 'bold' },
        },
        visual = {
            a = { fg = colors.on_tertiary, bg = colors.tertiary, gui = 'bold' },
        },
        replace = {
            a = { fg = colors.on_error, bg = colors.error, gui = 'bold' },
        },
        inactive = {
            a = { fg = colors.outline, bg = colors.surface_container_low },
            b = { fg = colors.outline, bg = colors.surface_container_low },
            c = { fg = colors.outline, bg = "none" },
        },
    }
end

-- Global reload function for convenience and manual triggering
_G.MatugenReload = function()
    local new_colors = get_matugen_colors()
    if new_colors then
        apply_matugen_colors(new_colors)
        enable_transparency()

        -- Update lualine if it's already loaded
        local status, lualine = pcall(require, "lualine")
        if status then
            lualine.setup({
                options = {
                    theme = get_lualine_theme(new_colors)
                }
            })
        end
        vim.notify("Matugen colors reloaded!", vim.log.levels.INFO)
    else
        vim.notify("Matugen colors file not found at ~/.config/nvim/matugen.lua", vim.log.levels.WARN)
    end
end

-- Create the command
vim.api.nvim_create_user_command("MatugenReload", _G.MatugenReload, {})

local colors = get_matugen_colors()

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
            apply_matugen_colors(colors)
            enable_transparency()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            theme = get_lualine_theme(colors),
            options = {
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            tabline = {
                lualine_a = {
                    {
                        'buffers',
                        show_filename_only = true,
                        hide_filename_extension = false,
                        show_modified_status = true,
                    }
                },
            },
        },
    },
}
