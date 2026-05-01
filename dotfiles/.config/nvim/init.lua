------------------------------------------------
--- mm   m mmmmmm  mmmm  m    m mmmmm  m    m
--- #"m  # #      m"  "m "m  m"   #    ##  ##
--- # #m # #mmmmm #    #  #  #    #    # ## #
--- #  # # #      #    #  "mm"    #    # "" #
--- #   ## #mmmmm  #mm#    ##   mm#mm  #    #
------------------------------------------------

vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require('lazy').setup({

	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

	-- LSP progress UI (no lspconfig or mason — servers configured via vim.lsp.config below)
	{ 'j-hui/fidget.nvim', opts = {} },

	-- Completion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'rafamadriz/friendly-snippets',
		},
	},

	-- Snacks (dashboard config lives in lua/dashboard.lua)
	{
		'folke/snacks.nvim',
		priority = 1000,
		lazy     = false,
		opts = function()
			return {
				bigfile   = { enabled = true },
				quickfile = { enabled = true },
				notifier  = { enabled = true, timeout = 3000 },
				input     = { enabled = true },
				indent    = { enabled = true, animate = { enabled = false } },
				picker    = { enabled = true },
				explorer  = { enabled = true },
				dashboard = require('dashboard').config(),
			}
		end,
		keys = {
			{ '<leader>e',  function() Snacks.explorer() end,                desc = 'File Explorer' },
			{ '<leader>E',  function() Snacks.explorer({ focus = true }) end, desc = 'Reveal in Explorer' },
			{ '<leader>bd', function() Snacks.bufdelete() end,               desc = 'Delete Buffer' },
			{ '<leader>un', function() Snacks.notifier.hide() end,           desc = 'Dismiss Notifications' },
		},
	},

	-- Keybind hints
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts  = { preset = 'helix', delay = 400 },
	},

	-- Git signs
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add          = { text = '+' },
				change       = { text = '~' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts        = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { expr = true, desc = 'Jump to next hunk' })

				map({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { expr = true, desc = 'Jump to previous hunk' })

				-- Actions
				map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'stage git hunk' })
				map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'reset git hunk' })
				map('n', '<leader>hs', gs.stage_hunk,        { desc = 'git stage hunk' })
				map('n', '<leader>hr', gs.reset_hunk,        { desc = 'git reset hunk' })
				map('n', '<leader>hS', gs.stage_buffer,      { desc = 'git Stage buffer' })
				map('n', '<leader>hu', gs.undo_stage_hunk,   { desc = 'undo stage hunk' })
				map('n', '<leader>hR', gs.reset_buffer,      { desc = 'git Reset buffer' })
				map('n', '<leader>hp', gs.preview_hunk,      { desc = 'preview git hunk' })
				map('n', '<leader>hb', function() gs.blame_line { full = false } end, { desc = 'git blame line' })
				map('n', '<leader>hd', gs.diffthis,          { desc = 'git diff against index' })
				map('n', '<leader>hD', function() gs.diffthis '~' end, { desc = 'git diff against last commit' })

				-- Toggles
				map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
				map('n', '<leader>td', gs.toggle_deleted,             { desc = 'toggle git show deleted' })

				-- Text object
				map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
			end,
		},
	},

	-- Colorscheme
	{
		'catppuccin/nvim',
		name     = 'catppuccin',
		priority = 1000,
		lazy     = false,
		config   = function()
			require('catppuccin').setup {
				flavour               = 'mocha',
				transparent_background = true,
				integrations = {
					cmp            = true,
					gitsigns       = true,
					telescope      = { enabled = true },
					treesitter     = true,
					which_key      = true,
					indent_blankline = { enabled = true },
					lualine        = true,
					snacks         = true,
				},
			}
			vim.cmd.colorscheme 'catppuccin'
		end,
	},

	-- Statusline
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'catppuccin/nvim' },
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled      = false,
					theme              = 'auto',
					component_separators = { left = '|', right = '|' },
					section_separators   = { left = '',  right = '' },
					globalstatus       = true,
					disabled_filetypes = { statusline = { 'snacks_dashboard' } },
				},
			}
		end,
	},

	-- Indent guides
	{ 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {} },

	-- Fuzzy finder
	{
		'nvim-telescope/telescope.nvim',
		version      = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond  = function() return vim.fn.executable('make') == 1 end,
			},
		},
	},

	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
		build        = ':TSUpdate',
	},
})

-- ============================================================
-- [[ Options ]]
-- ============================================================
vim.o.hlsearch    = false
vim.wo.number     = true
vim.o.mouse       = 'a'
vim.o.clipboard   = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile    = true
vim.o.swapfile    = false
vim.o.ignorecase  = true
vim.o.smartcase   = true
vim.opt.tabstop   = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab  = false
vim.wo.signcolumn  = 'yes'
vim.o.updatetime   = 250
vim.o.timeoutlen   = 300
vim.o.completeopt  = 'menuone,noselect'
vim.o.termguicolors = true

-- ============================================================
-- [[ Keymaps ]]
-- ============================================================
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p')
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,  { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,  { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>E',  vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q',  vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Cheatsheet
vim.keymap.set('n', '<leader>?', function() require('cheatsheet').show() end, { desc = 'Cheatsheet' })

-- ============================================================
-- [[ Autocommands ]]
-- ============================================================
local yank_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function() vim.highlight.on_yank() end,
	group    = yank_group,
	pattern  = '*',
})

-- ============================================================
-- [[ Telescope ]]
-- ============================================================
require('telescope').setup {
	defaults = {
		mappings = {
			i = { ['<C-u>'] = false, ['<C-d>'] = false },
		},
	},
}
pcall(require('telescope').load_extension, 'fzf')

local function find_git_root()
	local current_file = vim.api.nvim_buf_get_name(0)
	local cwd          = vim.fn.getcwd()
	local current_dir  = current_file == '' and cwd or vim.fn.fnamemodify(current_file, ':h')
	local git_root     = vim.fn.systemlist(
		'git -C ' .. vim.fn.shellescape(current_dir) .. ' rev-parse --show-toplevel'
	)[1]
	if vim.v.shell_error ~= 0 then
		vim.notify('Not a git repository, using cwd', vim.log.levels.WARN)
		return cwd
	end
	return git_root
end

local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		require('telescope.builtin').live_grep { search_dirs = { git_root } }
	end
end
vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader>?',  tb.oldfiles,    { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', tb.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	tb.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
	tb.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
end
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files,  { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', tb.builtin,                      { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', tb.git_files,                    { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', tb.find_files,                   { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', tb.help_tags,                    { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', tb.grep_string,                  { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', tb.live_grep,                    { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<CR>',          { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', tb.diagnostics,                  { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', tb.resume,                       { desc = '[S]earch [R]esume' })

-- ============================================================
-- [[ Treesitter ]]
-- ============================================================
vim.defer_fn(function()
	local ok, configs = pcall(require, 'nvim-treesitter.configs')
	if not ok then return end
	configs.setup {
		ensure_installed = {
			'c', 'cpp', 'go', 'lua', 'python', 'rust',
			'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash',
			'glsl', 'hlsl',  -- shader languages (handy for graphics work)
		},
		auto_install  = false,
		sync_install  = false,
		ignore_install = {},
		modules       = {},
		highlight     = { enable = true },
		indent        = { enable = true },
		incremental_selection = {
			enable  = true,
			keymaps = {
				init_selection    = '<C-space>',
				node_incremental  = '<C-space>',
				scope_incremental = '<C-s>',
				node_decremental  = '<M-space>',
			},
		},
		textobjects = {
			select = {
				enable    = true,
				lookahead = true,
				keymaps   = {
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable     = true,
				set_jumps  = true,
				goto_next_start     = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
				goto_next_end       = { [']M'] = '@function.outer', [']['] = '@class.outer' },
				goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
				goto_previous_end   = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
			},
			swap = {
				enable        = true,
				swap_next     = { ['<leader>a'] = '@parameter.inner' },
				swap_previous = { ['<leader>A'] = '@parameter.inner' },
			},
		},
	}
end, 0)

-- ============================================================
-- [[ LSP ]]
-- Uses Neovim 0.11+ native vim.lsp.config / vim.lsp.enable.
-- No nvim-lspconfig needed. Install servers via your system
-- package manager or language toolchains.
-- ============================================================

-- Keymaps and per-buffer setup wired through LspAttach autocmd.
vim.api.nvim_create_autocmd('LspAttach', {
	group    = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
	callback = function(ev)
		local bufnr = ev.buf
		local nmap  = function(keys, func, desc)
			vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
		end

		nmap('<leader>rn', vim.lsp.buf.rename,      '[R]e[n]ame')
		nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
		nmap('gd',  tb.lsp_definitions,             '[G]oto [D]efinition')
		nmap('gr',  tb.lsp_references,              '[G]oto [R]eferences')
		nmap('gI',  tb.lsp_implementations,         '[G]oto [I]mplementation')
		nmap('<leader>D',  tb.lsp_type_definitions, 'Type [D]efinition')
		nmap('<leader>ds', tb.lsp_document_symbols, '[D]ocument [S]ymbols')
		nmap('<leader>ws', tb.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
		nmap('K',    vim.lsp.buf.hover,             'Hover Documentation')
		nmap('<C-k>', vim.lsp.buf.signature_help,   'Signature Documentation')
		nmap('gD',   vim.lsp.buf.declaration,       '[G]oto [D]eclaration')

		vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
			vim.lsp.buf.format()
		end, { desc = 'Format current buffer with LSP' })
	end,
})

-- Merge cmp-nvim-lsp capabilities into every server config globally.
-- vim.lsp.config('*', ...) applies to all servers registered below.
vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Per-server configuration.
-- Each key matches the server name used by vim.lsp.enable().
-- Install binaries externally:
--   lua_ls      → https://github.com/luals/lua-language-server
--   clangd      → system package / llvm release (C, C++, GLSL via clangd-extensions)
--   gopls       → go install golang.org/x/tools/gopls@latest
--   pyright     → npm install -g pyright  OR  pipx install pyright
--   rust_analyzer → rustup component add rust-analyzer

vim.lsp.config('lua_ls', {
	cmd      = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
	settings = {
		Lua = {
			runtime   = { version = 'LuaJIT' },
			workspace = {
				checkThirdParty = false,
				-- Make lua_ls aware of nvim runtime files.
				library = vim.api.nvim_get_runtime_file('', true),
			},
			telemetry = { enable = false },
			diagnostics = { globals = { 'vim', 'Snacks' } },
		},
	},
})

vim.lsp.config('clangd', {
	cmd       = { 'clangd', '--background-index', '--clang-tidy' },
	filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
	root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
})

vim.lsp.config('gopls', {
	cmd          = { 'gopls' },
	filetypes    = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_markers = { 'go.work', 'go.mod', '.git' },
	settings = {
		gopls = {
			analyses  = { unusedparams = true },
			staticcheck = true,
		},
	},
})

vim.lsp.config('pyright', {
	cmd          = { 'pyright-langserver', '--stdio' },
	filetypes    = { 'python' },
	root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
})

vim.lsp.config('rust_analyzer', {
	cmd          = { 'rust-analyzer' },
	filetypes    = { 'rust' },
	root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },
	settings = {
		['rust-analyzer'] = {
			checkOnSave = { command = 'clippy' },
		},
	},
})

-- Enable all configured servers.
-- Comment out any you haven't installed yet.
vim.lsp.enable({
	'lua_ls',
	'clangd',
	'gopls',
	'pyright',
	'rust_analyzer',
})

-- ============================================================
-- [[ nvim-cmp ]]
-- ============================================================
local cmp     = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
	snippet = {
		expand = function(args) luasnip.lsp_expand(args.body) end,
	},
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	mapping = cmp.mapping.preset.insert {
		['<C-n>']     = cmp.mapping.select_next_item(),
		['<C-p>']     = cmp.mapping.select_prev_item(),
		['<C-b>']     = cmp.mapping.scroll_docs(-4),
		['<C-f>']     = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<CR>']      = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
	},
}

-- ============================================================
-- [[ which-key groups ]]
-- ============================================================
require('which-key').add {
	{ '<leader>c', group = '[C]ode' },
	{ '<leader>d', group = '[D]ocument' },
	{ '<leader>g', group = '[G]it' },
	{ '<leader>h', group = 'Git [H]unk' },
	{ '<leader>r', group = '[R]ename' },
	{ '<leader>s', group = '[S]earch' },
	{ '<leader>t', group = '[T]oggle' },
	{ '<leader>w', group = '[W]orkspace' },
	{ '<leader>b', group = '[B]uffer' },
	{ '<leader>u', group = '[U]I' },
	{ '<leader>',  group = 'VISUAL <leader>', mode = 'v' },
	{ '<leader>h', group = 'Git [H]unk',      mode = 'v' },
}
