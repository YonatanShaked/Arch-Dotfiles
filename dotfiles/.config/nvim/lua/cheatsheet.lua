-- lua/cheatsheet.lua
-- Floating cheatsheet popup — call M.show() to open

local M = {}

local content = [[
 NAVIGATION
  <C-h/j/k/l>      Move between windows
  <Tab> / <S-Tab>   Next / previous buffer
  <leader>e         Toggle file explorer
  <leader>E         Open floating diagnostic
  <C-d> / <C-u>     Half page down / up (centered)
  gd                Go to definition
  gr                Go to references
  gI                Go to implementation
  K                 Hover documentation

 FILES & SEARCH
  <leader><space>   Find files (buffers)
  <leader>/         Fuzzy search in buffer
  <leader>?         Recently opened files
  <leader>ss        Search select telescope
  <leader>sf        Search files
  <leader>sh        Search help tags
  <leader>sw        Search word under cursor
  <leader>sg        Search by grep
  <leader>sG        Search by grep (git root)
  <leader>sd        Search diagnostics
  <leader>sr        Resume last search

 GIT
  ]c / [c           Next / previous hunk
  <leader>hs        Stage hunk
  <leader>hp        Preview hunk
  <leader>hb        Blame line
  <leader>hd        Diff this file
  <leader>tb        Toggle git blame
  <leader>td        Toggle deleted

 LSP & CODE
  <leader>rn        Rename symbol
  <leader>ca        Code actions
  <leader>D         Type definition
  <leader>ds        Document symbols
  <leader>ws        Workspace symbols
  K                 Hover documentation
  <C-k>             Signature help
  [d / ]d           Prev / next diagnostic
  af / if           Around / inside function
  ac / ic           Around / inside class

 TOOLS
  <leader>?         Show this cheatsheet
  <leader>bd        Delete buffer
  <leader>un        Dismiss notifications
  :Lazy             Plugin manager
  :LspInfo          Active LSP servers
  :Format           Format buffer via LSP

 EDITING
  gc + motion       Toggle comment
  <C-space>         Expand treesitter selection
  <leader>y / p     Yank / paste system clipboard]]

M.show = function()
	local lines = {}
	for line in content:gmatch('[^\n]+') do
		table.insert(lines, line)
	end

	local width  = 60
	local height = math.min(#lines, vim.o.lines - 4)
	local row    = math.floor((vim.o.lines   - height) / 2)
	local col    = math.floor((vim.o.columns - width)  / 2)

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].filetype   = 'cheatsheet'

	local win = vim.api.nvim_open_win(buf, true, {
		relative  = 'editor',
		width     = width,
		height    = height,
		row       = row,
		col       = col,
		style     = 'minimal',
		border    = 'rounded',
		title     = '  Cheatsheet ',
		title_pos = 'center',
	})

	vim.wo[win].wrap       = false
	vim.wo[win].cursorline = true
	vim.wo[win].winblend   = 5

	-- Syntax highlighting
	local ns = vim.api.nvim_create_namespace('cheatsheet')
	for i, line in ipairs(lines) do
		if line:match('^ %u') then
			-- Section headers
			vim.api.nvim_buf_add_highlight(buf, ns, 'Function', i - 1, 0, -1)
		elseif line:match('^  %S') then
			-- Key bindings: highlight up to the two-space gap
			local key_end = line:find('  ', 3)
			if key_end then
				vim.api.nvim_buf_add_highlight(buf, ns, 'Special', i - 1, 2, key_end)
			end
		end
	end

	-- Close keymaps
	for _, key in ipairs({ 'q', '<Esc>', '<CR>', '?' }) do
		vim.keymap.set('n', key, '<cmd>close<CR>', { buffer = buf, silent = true, nowait = true })
	end
end

return M
