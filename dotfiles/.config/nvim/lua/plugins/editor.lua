return {
  -- ─── File explorer ───────────────────────────────────────────────────────────
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch       = "v3.x",
    cmd          = "Neotree",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorer" },
      { "<leader>E", "<cmd>Neotree reveal<CR>", desc = "Reveal current file" },
    },
    opts = {
      close_if_last_window = true,
      popup_border_style   = "rounded",
      enable_git_status    = true,
      window               = { width = 28, mappings = { ["<space>"] = "none" } },
      filesystem = {
        filtered_items      = { hide_dotfiles = false, hide_gitignored = true },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
    },
  },

  -- ─── Git ─────────────────────────────────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts  = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs  = package.loaded.gitsigns
        local map = function(l, r, desc)
          vim.keymap.set("n", l, r, { buffer = bufnr, desc = desc })
        end
        map("]h", gs.next_hunk,  "Next hunk")
        map("[h", gs.prev_hunk,  "Prev hunk")
        map("<leader>ghs", gs.stage_hunk,   "Stage hunk")
        map("<leader>ghr", gs.reset_hunk,   "Reset hunk")
        map("<leader>ghS", gs.stage_buffer, "Stage buffer")
        map("<leader>ghp", gs.preview_hunk, "Preview hunk")
        map("<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("<leader>ghd", gs.diffthis,     "Diff this")
        vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Select hunk" })
      end,
    },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd          = "LazyGit",
    keys         = { { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" } },
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- ─── Formatting ──────────────────────────────────────────────────────────────
  -- Runs on save + on <leader>lf. LSP servers (ruff, clangd) handle linting.
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd   = "ConformInfo",
    opts  = {
      formatters_by_ft = {
        lua      = { "stylua" },
        python   = { "ruff_format", "ruff_organize_imports" },
        c        = { "clang_format" },
        cpp      = { "clang_format" },
        cuda     = { "clang_format" },
        sh       = { "shfmt" },
        json     = { "prettierd" },
        jsonc    = { "prettierd" },
        yaml     = { "prettierd" },
        markdown = { "prettierd" },
      },
      format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
    },
  },

  -- ─── Flash jump ──────────────────────────────────────────────────────────────
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts  = { modes = { search = { enabled = true }, char = { jump_labels = true } } },
    keys  = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    },
  },

  -- ─── Mini ────────────────────────────────────────────────────────────────────
  {
    "echasnovski/mini.nvim",
    version = "*",
    event   = "VeryLazy",
    config  = function()
      require("mini.ai").setup({ n_lines = 500 })  -- af/if/ac/ic text objects
      require("mini.pairs").setup()                 -- auto close brackets/quotes
      require("mini.move").setup()                  -- <M-hjkl> move lines/selection
    end,
  },

  -- ─── DAP (C/C++/CUDA + Python) ───────────────────────────────────────────────
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                         desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                  desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end,                                 desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end,                                 desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end,                                  desc = "Step out" },
      { "<leader>du", function() require("dapui").toggle() end,                                  desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" },               desc = "Evaluate expression" },
      { "<leader>dt", function() require("dap").terminate() end,                                 desc = "Terminate" },
    },
    config = function()
      local dap   = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        ensure_installed       = { "codelldb", "debugpy" },
        automatic_installation = true,
        handlers               = {},
      })

      require("nvim-dap-virtual-text").setup({ commented = true })
      dapui.setup({ floating = { border = "rounded" } })

      dap.listeners.after.event_initialized["dapui"] = dapui.open
      dap.listeners.before.event_terminated["dapui"] = dapui.close
      dap.listeners.before.event_exited["dapui"]     = dapui.close

      require("dap-python").setup(
        vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      )

      dap.adapters.codelldb = {
        type = "server", port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args    = { "--port", "${port}" },
        },
      }
      for _, ft in ipairs({ "c", "cpp", "cuda" }) do
        dap.configurations[ft] = {
          {
            name        = "Launch",
            type        = "codelldb",
            request     = "launch",
            program     = function()
              return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd         = "${workspaceFolder}",
            stopOnEntry = false,
          },
        }
      end
    end,
  },
}
