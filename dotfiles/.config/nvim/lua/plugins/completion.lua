return {
  -- ─── blink.cmp ───────────────────────────────────────────────────────────────
  {
    "saghen/blink.cmp",
    version      = "*",
    event        = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
    },
    opts         = {
      -- Use the luasnip preset for snippet integration
      snippets = { preset = "luasnip" },

      keymap = {
        preset        = "default",
        ["<Tab>"]     = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"]   = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"]      = { "accept", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"]     = { "hide", "fallback" },
        ["<C-f>"]     = { "scroll_documentation_down", "fallback" },
        ["<C-b>"]     = { "scroll_documentation_up", "fallback" },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      cmdline = {
        enabled = true,
        keymap  = { preset = "cmdline" }, -- <Tab>/<S-Tab> cycle, <CR> confirm
        sources = { "cmdline", "path" },
      },

      completion = {
        accept        = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show          = true,
          auto_show_delay_ms = 200,
          window             = { border = "rounded" },
        },
        ghost_text    = { enabled = true },
        menu          = {
          border = "rounded",
          draw   = {
            treesitter = { "lsp" },
            columns    = {
              { "label",     "label_description", gap = 1 },
              { "kind_icon", "kind",              gap = 1 },
            },
          },
        },
      },

      signature = {
        enabled = true,
        window  = { border = "rounded" },
      },
    },
  },

  -- ─── LuaSnip ─────────────────────────────────────────────────────────────────
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = "rafamadriz/friendly-snippets",
    keys = {
      { "<C-l>", function() require("luasnip").expand_or_jump() end, mode = { "i", "s" }, desc = "Expand/jump" },
      { "<C-h>", function() require("luasnip").jump(-1) end,         mode = { "i", "s" }, desc = "Jump back" },
    },
    config = function()
      local ls = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Load any project-local snippets if they exist
      local snippet_dir = vim.fn.stdpath("config") .. "/snippets"
      if vim.fn.isdirectory(snippet_dir) == 1 then
        require("luasnip.loaders.from_lua").lazy_load({ paths = { snippet_dir } })
      end
      ls.config.setup({ history = true, updateevents = "TextChanged,TextChangedI" })
    end,
  },
}
