return {
  {
    "nvim-telescope/telescope.nvim",
    cmd          = "Telescope",
    version      = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader><space>", "<cmd>Telescope find_files<CR>",   desc = "Find files" },
      { "<leader>ff",      "<cmd>Telescope find_files<CR>",   desc = "Find files" },
      { "<leader>fr",      "<cmd>Telescope oldfiles<CR>",     desc = "Recent files" },
      { "<leader>fb",      "<cmd>Telescope buffers<CR>",      desc = "Buffers" },
      { "<leader>fg",      "<cmd>Telescope git_files<CR>",    desc = "Git files" },
      { "<leader>/",       "<cmd>Telescope live_grep<CR>",    desc = "Grep" },
      { "<leader>sw",      "<cmd>Telescope grep_string<CR>",  desc = "Search word" },
      { "<leader>sh",      "<cmd>Telescope help_tags<CR>",    desc = "Search help" },
      { "<leader>sk",      "<cmd>Telescope keymaps<CR>",      desc = "Search keymaps" },
      { "<leader>sd",      "<cmd>Telescope diagnostics<CR>",  desc = "Search diagnostics" },
      { "<leader>sr",      "<cmd>Telescope resume<CR>",       desc = "Resume last search" },
      { "<leader>gc",      "<cmd>Telescope git_commits<CR>",  desc = "Git commits" },
      { "<leader>gb",      "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
      { "<leader>gs",      "<cmd>Telescope git_status<CR>",   desc = "Git status" },
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix    = "  ",
          selection_caret  = " ",
          path_display     = { "truncate" },
          sorting_strategy = "ascending",
          layout_config    = {
            horizontal     = { prompt_position = "top", preview_width = 0.55 },
            width          = 0.87,
            height         = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
              ["<C-u>"] = false,
            },
          },
        },
        extensions = {
          fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
        },
      })

      telescope.load_extension("fzf")
    end,
  },
}
