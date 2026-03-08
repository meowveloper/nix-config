local fix_vue_lsp = require("utils.fix-vue-lsp").main
local adjust_lua_lsp = require("utils.adjust-lua-lsp").adjust_lua_lsp
return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "lua_ls",
            "vimls",
            "vtsls",
            "vue_ls",
            "zls",
            "clangd",
            "rnix",
            "efm",
        }
    },
    config = function()
        fix_vue_lsp()
        adjust_lua_lsp()
    end,
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
}
