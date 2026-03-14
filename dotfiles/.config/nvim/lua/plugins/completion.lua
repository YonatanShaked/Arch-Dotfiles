return {
  {
    "saghen/blink.cmp",
    version      = "*",
    event        = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      snippets = { preset = "default" },

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
        keymap  = { preset = "cmdline" },
        sources = { "cmdline", "path" },
      },

      completion = {
        accept        = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show          = true,
          auto_show_delay_ms = 200,
          window             = { border = "rounded" },
        },
        ghost_text = { enabled = true },
        menu = {
          border = "rounded",
          draw   = {
            treesitter = { "lsp" },
            columns    = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
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
}
