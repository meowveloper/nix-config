-- https://github.com/hrsh7th/nvim-cmp.git
-- https://github.com/onsails/lspkind.nvim.git
-- https://github.com/L3MON4D3/LuaSnip.git
-- https://github.com/saadparwaiz1/cmp_luasnip.git
-- https://github.com/rafamadriz/friendly-snippets.git
-- https://github.com/hrsh7th/cmp-nvim-lsp.git
-- https://github.com/hrsh7th/cmp-buffer.git
-- https://github.com/hrsh7th/cmp-path.git


return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "onsails/lspkind.nvim",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    config = function()
        local lspkind = require("lspkind")
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                })
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),

            sources = {
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "codeium" },
            },
        })
    end,
}
