local M = {}

M.on_attach = function(client, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  map("gd", "<cmd>Telescope lsp_definitions<CR>",     "Go to definition")
  map("gD", vim.lsp.buf.declaration,                   "Go to declaration")
  map("gr", "<cmd>Telescope lsp_references<CR>",       "Go to references")
  map("gI", "<cmd>Telescope lsp_implementations<CR>",  "Go to implementation")
  map("gy", "<cmd>Telescope lsp_type_definitions<CR>", "Go to type definition")
  map("K",           vim.lsp.buf.hover,                "Hover documentation")
  map("<leader>lk",  vim.lsp.buf.signature_help,       "Signature help")
  map("<leader>lr",  vim.lsp.buf.rename,               "Rename symbol")
  map("<leader>la",  vim.lsp.buf.code_action,          "Code action")
  map("<leader>lf",  function() require("conform").format({ async = true, lsp_format = "fallback" }) end, "Format file")
  map("<leader>li",  "<cmd>LspInfo<CR>",               "LSP info")
  map("<leader>lR",  "<cmd>LspRestart<CR>",            "Restart LSP")

  if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
    map("<leader>uh", function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr }
      )
    end, "Toggle inlay hints")
  end
end

M.capabilities = function()
  local caps = vim.lsp.protocol.make_client_capabilities()
  local ok, blink = pcall(require, "blink.cmp")
  if ok then caps = blink.get_lsp_capabilities(caps) end
  return caps
end

vim.diagnostic.config({
  severity_sort    = true,
  underline        = true,
  update_in_insert = false,
  virtual_text     = {
    spacing = 4,
    source  = "if_many",
    prefix  = function(d)
      return ({ [1] = "󰅚 ", [2] = " ", [3] = " ", [4] = " " })[d.severity] or " "
    end,
  },
  float = { border = "rounded", source = true },
})

for type, icon in pairs({ Error = "󰅚 ", Warn = " ", Hint = " ", Info = " " }) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

return M
