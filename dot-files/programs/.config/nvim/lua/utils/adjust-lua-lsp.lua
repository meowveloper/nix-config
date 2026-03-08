local M = {}

M.adjust_lua_lsp = function ()
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                },
                workspace = {
                    library = {
                        vim.fn.expand("$VIMRUNTIME/lua"),
                        -- vim.vn.expand("$XDG_CONFIG_HOME") .. "/nvim-2/lua"
                    }
                }
            }
        }
    })
end

return M
