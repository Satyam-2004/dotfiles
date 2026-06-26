return {
    {
        "neovim/nvim-lspconfig",
        version = "v2.10.0",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },

        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("clangd", {
                cmd = {
                    "C:/msys64/ucrt64/bin/clangd.exe",
                    "--background-index",
                    "--clang-tidy",
                },

                capabilities = capabilities,

                root_markers = {
                    ".git",
                    ".clangd",
                    "compile_commands.json",
                    "compile_flags.txt",
                },
            })

            vim.lsp.enable("clangd")

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local opts = { buffer = event.buf, silent = true }

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                end,
            })
        end,
    },
}
