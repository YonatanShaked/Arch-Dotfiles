return {
  -- ─── Mason ───────────────────────────────────────────────────────────────────
  {
    "williamboman/mason.nvim",
    cmd   = "Mason",
    keys  = { { "<leader>m", "<cmd>Mason<CR>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts  = {
      ui = {
        border = "rounded",
        icons  = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
      },
    },
  },

  -- ─── Mason-lspconfig ─────────────────────────────────────────────────────────
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig    = require("lspconfig")
      local on_attach    = require("lsp").on_attach
      local capabilities = require("lsp").capabilities()

      local servers = {
        clangd = {
          cmd = {
            "clangd", "--background-index", "--clang-tidy",
            "--completion-style=detailed", "--header-insertion=iwyu",
            "--suggest-missing-includes", "--cross-file-rename",
          },
          init_options = { usePlaceholders = true, completeUnimported = true },
          filetypes    = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
        pyright = {
          settings = {
            python = { analysis = {
              autoSearchPaths        = true,
              diagnosticMode         = "workspace",
              useLibraryCodeForTypes = true,
              typeCheckingMode       = "basic",
            }},
          },
        },
        ruff = {
          on_attach = function(client, bufnr)
            client.server_capabilities.hoverProvider = false
            on_attach(client, bufnr)
          end,
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime    = { version = "LuaJIT" },
              workspace  = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
              telemetry  = { enable = false },
              diagnostics = { globals = { "vim" } },
              hint        = { enable = true },
              format      = { enable = false },
            },
          },
        },
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = { json = { validate = { enable = true } } },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
            },
          },
        },
      }

      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",   -- C / C++ / CUDA
          "pyright",  -- Python
          "ruff",     -- Python linting/formatting
          "lua_ls",   -- Lua
          "jsonls",   -- JSON
          "yamlls",   -- YAML
        },
        automatic_installation = true,
        handlers = {
          function(server)
            lspconfig[server].setup(vim.tbl_deep_extend("force", {
              on_attach    = on_attach,
              capabilities = capabilities,
            }, servers[server] or {}))
          end,
        },
      })
    end,
  },

  { "neovim/nvim-lspconfig", lazy = false },
  { "b0o/SchemaStore.nvim",  lazy = true },
}
