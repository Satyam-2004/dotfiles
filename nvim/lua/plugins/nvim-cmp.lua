return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = { "saadparwaiz1/cmp_luasnip" },
    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },

  config = function()
    if vim.g.vscode then return end   -- skip in vscode-neovim

    local cmp = require("cmp")
    local luasnip = require("luasnip")

    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = {
        completeopt = "menu,menuone,noinsert",   -- most people prefer noinsert
      },

      mapping = cmp.mapping.preset.insert({
        -- Super-Tab style: navigate + smart confirm
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You can swap the next two lines depending on preference:
            -- Option A: Always confirm on Tab (very VSCode-like)
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
            
            -- Option B: Select next → only confirm when you want (more conservative)
            -- cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()   -- normal indent / tab when no completion
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Classic scroll documentation
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Manual trigger completion (optional but useful)
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Enter = NEW LINE (very important for most coders!)
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()  -- normal <CR>
            end
          end,
          s = cmp.mapping.confirm({ select = true }),   -- snippet mode
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),

        -- Keep your luasnip navigation (can remove if you prefer Tab only)
        -- ["<C-l>"] = cmp.mapping(function()
        --   if luasnip.expand_or_locally_jumpable() then
        --     luasnip.expand_or_jump()
        --   end
        -- end, { "i", "s" }),
        --
        -- ["<C-h>"] = cmp.mapping(function()
        --   if luasnip.locally_jumpable(-1) then
        --     luasnip.jump(-1)
        --   end
        -- end, { "i", "s" }),
      }),

      sources = {
        { name = "lazydev", group_index = 0 },   -- optional
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
      },
    })
  end,
}
