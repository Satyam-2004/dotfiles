return {
  {
    "neovim/nvim-lspconfig", -- core LSP support
    dependencies = {
      "williamboman/mason.nvim", -- installer
      "williamboman/mason-lspconfig.nvim", -- bridge between mason & lspconfig
      "hrsh7th/cmp-nvim-lsp", -- completion capabilities
    },
    config = function()
      -- Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",       -- Python
          "ts_ls",      -- JavaScript/TypeScript
          "jdtls",         -- Java
          "clangd",        -- C/C++
        },
        automatic_installation = true,
      })

      -- Add nvim-cmp capabilities (if you use cmp)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")

      -- Python
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      -- JavaScript / TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      -- Java (jdtls is special – usually started per-project)
      lspconfig.jdtls.setup({
        capabilities = capabilities,
      })

      -- C / C++
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      -- Go
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })

      -- General keymaps (example)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    end,
  },
}

