local M = {}

M.adjust_python_lsp = function ()
    vim.lsp.config("basedpyright", {
        settings = {
            basedpyright = {
                analysis = {
                    typeCheckingMode = "standard",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "openFilesOnly",
                },
            },
        },
    })

    vim.lsp.config("efm", {
        settings = {
            rootMarkers = { ".git/" },
            languages = {
                python = {
                    lintCommand = "ruff check --output-format concise ${FILENAME}",
                    lintStdin = true,
                    lintFormats = { "%f:%l:%c: %m" },
                    formatCommand = "ruff format --stdin-filename ${FILENAME} -",
                    formatStdin = true,
                },
            },
        },
    })
end

return M