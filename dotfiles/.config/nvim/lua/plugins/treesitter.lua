return {
  {
    "nvim-treesitter/nvim-treesitter",
    version      = false,
    build        = ":TSUpdate",
    event        = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      vim.schedule(function()
        local ok, ts = pcall(require, "nvim-treesitter.configs")
        if not ok then return end
        ts.setup({
          ensure_installed = {
            "c", "cpp", "cuda",
            "python",
            "lua", "luadoc", "vim", "vimdoc",
            "json", "jsonc", "yaml", "toml",
            "markdown", "markdown_inline", "bash",
            "gitcommit", "gitignore",
          },
          auto_install = true,
          highlight    = { enable = true },
          indent       = { enable = true },
          incremental_selection = {
            enable  = true,
            keymaps = {
              init_selection   = "<C-space>",
              node_incremental = "<C-space>",
              node_decremental = "<BS>",
            },
          },
          textobjects = {
            select = {
              enable    = true,
              lookahead = true,
              keymaps   = {
                ["af"] = "@function.outer", ["if"] = "@function.inner",
                ["ac"] = "@class.outer",    ["ic"] = "@class.inner",
                ["aa"] = "@parameter.outer",["ia"] = "@parameter.inner",
                ["ab"] = "@block.outer",    ["ib"] = "@block.inner",
              },
            },
            move = {
              enable    = true,
              set_jumps = true,
              goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
              goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            },
          },
        })

        local ok2, ctx = pcall(require, "treesitter-context")
        if ok2 then ctx.setup({ max_lines = 3, separator = "─" }) end
      end)
    end,
  },
}
