local opt = vim.opt
local g = vim.g

-- Leader
g.mapleader = " "
g.maplocalleader = "\\"

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.termguicolors = true
opt.showmode = false          -- statusline handles this
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 10             -- floating window transparency
opt.laststatus = 3            -- global statusline
opt.cmdheight = 1
opt.showcmd = false
opt.ruler = false
opt.numberwidth = 3
opt.splitbelow = true
opt.splitright = true

-- Transparency: let the terminal background show through
opt.background = "dark"

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Files
opt.undofile = true
opt.undolevels = 10000
opt.backup = false
opt.swapfile = false
opt.autowrite = true
opt.confirm = true

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300
opt.redrawtime = 10000

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Cmdline tab completion (NvChad style wildmenu)
opt.wildmenu   = true
opt.wildmode   = "longest:full,full"  -- first tab completes longest match, second opens menu
opt.wildoptions = "pum"               -- show completions in popup menu (like nvchad)

-- Folding (using treesitter/ufo)
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Misc
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.fileencoding = "utf-8"
opt.fillchars = {
  fold     = " ",
  foldopen = "▾",
  foldclose = "▸",
  foldsep  = "│",
  diff     = "╱",
  eob      = " ",
}
opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}
opt.formatoptions = "jcroqlnt"
opt.conceallevel = 2
opt.spelllang = { "en" }
opt.virtualedit = "block"
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Grep
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Disable some providers
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
