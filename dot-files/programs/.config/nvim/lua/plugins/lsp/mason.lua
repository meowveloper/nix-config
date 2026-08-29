local fix_vue_lsp = require("utils.fix-vue-lsp").main
local adjust_lua_lsp = require("utils.adjust-lua-lsp").adjust_lua_lsp
local adjust_python_lsp = require("utils.adjust-python-lsp").adjust_python_lsp
return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "lua_ls",
            "vimls",
            "vtsls",
            "zls",
            "clangd",
            "rust_analyzer",
            "efm",
            "basedpyright",
        },
        -- vue is handled by vtsls + the @vue/typescript-plugin (see utils/fix-vue-lsp.lua);
        -- keep the standalone vue_ls (volar) server from also attaching to .vue files
        automatic_enable = {
            exclude = { "vue_ls" },
        },
    },
    config = function(_, opts)
        -- NB: a custom `config` replaces lazy's default, so setup() must be called here
        -- or no servers get installed/enabled (vim.lsp.enable is never invoked).
        require("mason-lspconfig").setup(opts)
        fix_vue_lsp()
        adjust_lua_lsp()
        adjust_python_lsp()
        -- nixd comes from home.packages (not mason), so enable it explicitly
        vim.lsp.enable("nixd")
    end,
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
}
