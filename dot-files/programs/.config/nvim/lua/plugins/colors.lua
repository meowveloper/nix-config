local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end
return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
            enable_transparency()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            theme = "tokyonight",
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
