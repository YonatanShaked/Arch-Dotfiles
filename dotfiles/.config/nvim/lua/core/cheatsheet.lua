local M = {}

local content = [[
 NAVIGATION
  <C-h/j/k/l>      Move between windows
  <Tab> / <S-Tab>   Next / previous buffer
  <leader>w         Close current buffer
  <leader>e         Toggle file explorer
  <leader>E         Reveal current file in explorer
  H / L             Jump to start / end of line
  <C-d> / <C-u>     Half page down / up (centered)
  s                 Flash jump (type chars to jump anywhere)
  S                 Flash jump using treesitter nodes
  gd                Go to definition
  gr                Go to references
  gI                Go to implementation
  K                 Hover documentation

 FILES & SEARCH
  <leader><space>   Find files
  <leader>/         Live grep across project
  <leader>fr        Recent files
  <leader>fb        Open buffers
  <leader>sw        Search word under cursor
  <leader>sh        Search help tags
  <leader>sr        Resume last search

 GIT
  <leader>gg        Open Lazygit (full git UI)
  <leader>gd        Diff view (side by side)
  <leader>gh        File history
  ]h / [h           Next / previous git hunk
  <leader>ghs       Stage hunk
  <leader>ghp       Preview hunk
  <leader>ghb       Blame current line

 LSP & CODE
  <leader>lr        Rename symbol
  <leader>la        Code actions
  <leader>lf        Format file
  <leader>lk        Signature help
  <leader>uh        Toggle inlay hints
  <leader>cd        Show diagnostic detail
  ]d / [d           Next / previous diagnostic
  <leader>xx        Workspace diagnostics panel
  <leader>xb        Buffer diagnostics panel

 DEBUG
  <leader>db        Toggle breakpoint
  <leader>dB        Conditional breakpoint
  <leader>dc        Continue / start debugger
  <leader>di        Step into
  <leader>do        Step over
  <leader>dO        Step out
  <leader>du        Toggle debug UI
  <leader>de        Evaluate expression (visual works too)
  <leader>dt        Terminate session

 TERMINAL
  <C-t>             Toggle floating terminal
  <leader>th        Horizontal split terminal
  <leader>tv        Vertical split terminal
  <Esc><Esc>        Exit terminal mode

 TOOLS
  <leader>?         Show this cheatsheet
  <leader>m         Mason (LSP/tool installer)
  :Lazy             Plugin manager
  :ConformInfo      Show active formatters
  :LspInfo          Show active LSP servers
  <leader>uw        Toggle line wrap
  <leader>us        Toggle spell check
  <leader>un        Dismiss notifications

 EDITING
  <C-s>             Save file
  jk                Exit insert mode
  <leader>y         Yank to system clipboard
  gc (+ motion)     Toggle comment
  <M-hjkl>          Move line/selection (mini.move)
  af / if           Around / inside function (text object)
  ac / ic           Around / inside class (text object)
  <M-l>             Accept Copilot suggestion
]]

function M.show()
  local lines = {}
  for line in content:gmatch("[^\n]+") do
    table.insert(lines, line)
  end

  local c     = _G.Mocha or {}
  local width = 58
  local height = #lines
  local row   = math.floor((vim.o.lines - height) / 2)
  local col   = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype   = "markdown"

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width    = width,
    height   = height,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = "rounded",
    title    = "  Cheatsheet ",
    title_pos = "center",
  })

  vim.wo[win].wrap      = false
  vim.wo[win].cursorline = true
  vim.wo[win].winblend  = 5

  -- Highlight section headers
  local ns = vim.api.nvim_create_namespace("cheatsheet")
  for i, line in ipairs(lines) do
    if line:match("^ %u") then
      vim.api.nvim_buf_add_highlight(buf, ns, "Function", i - 1, 0, -1)
    elseif line:match("^  %S") then
      -- key part up to first two spaces after the key
      local key_end = line:find("  ", 3)
      if key_end then
        vim.api.nvim_buf_add_highlight(buf, ns, "Special", i - 1, 2, key_end)
      end
    end
  end

  -- Close on any of these
  for _, key in ipairs({ "q", "<Esc>", "<CR>", "?" }) do
    vim.keymap.set("n", key, "<cmd>close<CR>", { buffer = buf, silent = true })
  end
end

return M
