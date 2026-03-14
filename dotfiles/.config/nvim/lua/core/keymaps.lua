local map = vim.keymap.set

-- ─── Window navigation (standard vim splits, just easier) ────────────────────
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- ─── Resize splits ───────────────────────────────────────────────────────────
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { silent = true })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { silent = true })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { silent = true })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { silent = true })

-- ─── Buffer navigation ───────────────────────────────────────────────────────
map("n", "<Tab>",   "<cmd>bnext<CR>",     { silent = true })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true })

-- ─── Keep visual selection when indenting ────────────────────────────────────
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

-- ─── Center search results ───────────────────────────────────────────────────
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })

-- ─── Diagnostics ─────────────────────────────────────────────────────────────
map("n", "[d", vim.diagnostic.goto_prev,       { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next,       { desc = "Next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostic detail" })

-- ─── Quickfix ────────────────────────────────────────────────────────────────
map("n", "[q", "<cmd>cprev<CR>zz", { silent = true })
map("n", "]q", "<cmd>cnext<CR>zz", { silent = true })

-- ─── Terminal: escape back to normal mode ────────────────────────────────────
map("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { silent = true })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { silent = true })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { silent = true })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { silent = true })

-- ─── UI toggles ──────────────────────────────────────────────────────────────
map("n", "<leader>uw", function() vim.opt.wrap = not vim.opt.wrap:get() end,   { desc = "Toggle wrap" })
map("n", "<leader>us", function() vim.opt.spell = not vim.opt.spell:get() end, { desc = "Toggle spell" })
map("n", "<leader>un", function() Snacks.notifier.hide() end,                  { desc = "Dismiss notifications" })
