return {
  -- ─── Statusline ──────────────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event        = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local c     = _G.Mocha or {}
      local icons = require("core.icons")
      return {
        options = {
          theme = {
            normal   = { a = { fg = c.base, bg = c.mauve,    gui = "bold" }, b = { fg = c.text, bg = "NONE" }, c = { fg = c.text, bg = "NONE" } },
            insert   = { a = { fg = c.base, bg = c.green,    gui = "bold" } },
            visual   = { a = { fg = c.base, bg = c.flamingo, gui = "bold" } },
            replace  = { a = { fg = c.base, bg = c.red,      gui = "bold" } },
            command  = { a = { fg = c.base, bg = c.peach,    gui = "bold" } },
            inactive = { a = { fg = c.surface2, bg = "NONE" }, b = { fg = c.surface2, bg = "NONE" }, c = { fg = c.surface2, bg = "NONE" } },
          },
          component_separators = "",
          section_separators   = { left = "", right = "" },
          globalstatus         = true,
          disabled_filetypes   = { statusline = { "snacks_dashboard" } },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = {
            { "branch", icon = "" },
            { "diff", symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed } },
          },
          lualine_c = {
            { "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
            { "diagnostics", symbols = { error = icons.diag.error, warn = icons.diag.warn, hint = icons.diag.hint, info = icons.diag.info } },
          },
          lualine_x = {
            { function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = { fg = c.red } },
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
        },
      }
    end,
  },

  -- ─── Snacks ──────────────────────────────────────────────────────────────────
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy     = false,
    opts = {
      bigfile   = { enabled = true },
      dashboard = {
        enabled = true,
        preset  = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          keys = {
            { icon = "󰮗 ", key = "f", desc = "Find File",    action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "n", desc = "New File",     action = ":enew | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
            { icon = "󰊄 ", key = "g", desc = "Grep Text",    action = ":lua Snacks.picker.grep()" },
            { icon = " ", key = "e", desc = "Explorer",     action = ":Neotree toggle" },
            { icon = "󰒲 ", key = "l", desc = "Lazy",         action = ":Lazy" },
            { icon = "󱌣 ", key = "m", desc = "Mason",        action = ":Mason" },
            { icon = "󰋗 ", key = "?", desc = "Help",         action = ":lua require('core.cheatsheet').show()" },
            { icon = "󰈆 ", key = "q", desc = "Quit",         action = ":qa" },
          },
        },
      },
      indent   = { enabled = true, animate = { enabled = false } },
      input    = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      quickfile = { enabled = true },
    },
    keys = {},
  },

  -- ─── Which-key ───────────────────────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys  = {
      { "<leader>?", function() require("core.cheatsheet").show() end, desc = "Cheatsheet" },
    },
    opts  = {
      preset = "helix",
      delay  = 400,
      spec   = {
        { "<leader>d",  group = "debug" },
        { "<leader>f",  group = "files" },
        { "<leader>g",  group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>l",  group = "lsp" },
        { "<leader>s",  group = "search" },
        { "<leader>u",  group = "ui" },
        { "[",          group = "prev" },
        { "]",          group = "next" },
      },
    },
  },
}
