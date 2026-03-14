-- Catppuccin Mocha colors hardcoded — no plugin dependency
-- https://github.com/catppuccin/catppuccin#-palette
local M = {}

M.mocha = {
  rosewater = "#f5e0dc",
  flamingo  = "#f2cdcd",
  pink      = "#f5c2e7",
  mauve     = "#cba6f7",
  red       = "#f38ba8",
  maroon    = "#eba0ac",
  peach     = "#fab387",
  yellow    = "#f9e2af",
  green     = "#a6e3a1",
  teal      = "#94e2d5",
  sky       = "#89dceb",
  sapphire  = "#74c7ec",
  blue      = "#89b4fa",
  lavender  = "#b4befe",
  text      = "#cdd6f4",
  subtext1  = "#bac2de",
  subtext0  = "#a6adc8",
  overlay2  = "#9399b2",
  overlay1  = "#7f849c",
  overlay0  = "#6c7086",
  surface2  = "#585b70",
  surface1  = "#45475a",
  surface0  = "#313244",
  base      = "#1e1e2e",
  mantle    = "#181825",
  crust     = "#11111b",
}

-- Expose palette globally so other plugins (bufferline, lualine) can use it
_G.Mocha = M.mocha

return {
  {
    -- Virtual plugin: no remote repo needed.
    -- dir points to the config itself so Lazy treats it as a local plugin.
    dir      = vim.fn.stdpath("config"),
    name     = "mocha-theme",
    priority = 1000,
    lazy     = false,
    config   = function()
      local c   = M.mocha
      local hi  = vim.api.nvim_set_hl

      vim.cmd("highlight clear")
      vim.cmd("syntax reset")
      vim.o.termguicolors = true
      vim.g.colors_name   = "catppuccin-mocha"

      -- ── Editor base ──────────────────────────────────────────────────────────
      hi(0, "Normal",       { fg = c.text,     bg = "NONE" })   -- transparent bg
      hi(0, "NormalNC",     { fg = c.text,     bg = "NONE" })
      hi(0, "NormalFloat",  { fg = c.text,     bg = "NONE" })
      hi(0, "FloatBorder",  { fg = c.surface2, bg = "NONE" })
      hi(0, "FloatTitle",   { fg = c.lavender, bg = "NONE", bold = true })
      hi(0, "SignColumn",   { fg = c.surface1, bg = "NONE" })
      hi(0, "ColorColumn",  { bg = c.surface0 })
      hi(0, "CursorLine",   { bg = c.surface0 })
      hi(0, "CursorColumn", { bg = c.surface0 })
      hi(0, "CursorLineNr", { fg = c.lavender, bold = true })
      hi(0, "LineNr",       { fg = c.surface2 })
      hi(0, "LineNrAbove",  { fg = c.surface2 })
      hi(0, "LineNrBelow",  { fg = c.surface2 })
      hi(0, "FoldColumn",   { fg = c.overlay0, bg = "NONE" })
      hi(0, "Folded",       { fg = c.blue,     bg = c.surface0 })

      -- ── Statusline / Tabline ─────────────────────────────────────────────────
      hi(0, "StatusLine",   { fg = c.text,     bg = "NONE" })
      hi(0, "StatusLineNC", { fg = c.surface2, bg = "NONE" })
      hi(0, "TabLine",      { fg = c.surface2, bg = "NONE" })
      hi(0, "TabLineFill",  { bg = "NONE" })
      hi(0, "TabLineSel",   { fg = c.mauve,    bg = "NONE", bold = true })

      -- ── Pmenu (completion) ───────────────────────────────────────────────────
      hi(0, "Pmenu",        { fg = c.text,    bg = c.surface0 })
      hi(0, "PmenuSel",     { fg = c.base,    bg = c.mauve,    bold = true })
      hi(0, "PmenuSbar",    { bg = c.surface0 })
      hi(0, "PmenuThumb",   { bg = c.surface2 })
      hi(0, "PmenuBorder",  { fg = c.surface2, bg = "NONE" })

      -- ── Search ───────────────────────────────────────────────────────────────
      hi(0, "Search",       { fg = c.base,    bg = c.yellow })
      hi(0, "IncSearch",    { fg = c.base,    bg = c.peach,  bold = true })
      hi(0, "CurSearch",    { fg = c.base,    bg = c.peach,  bold = true })
      hi(0, "Substitute",   { fg = c.base,    bg = c.red })

      -- ── Visual ───────────────────────────────────────────────────────────────
      hi(0, "Visual",       { bg = c.surface1 })
      hi(0, "VisualNOS",    { bg = c.surface1 })

      -- ── Diff ─────────────────────────────────────────────────────────────────
      hi(0, "DiffAdd",      { fg = c.green,  bg = "NONE" })
      hi(0, "DiffChange",   { fg = c.yellow, bg = "NONE" })
      hi(0, "DiffDelete",   { fg = c.red,    bg = "NONE" })
      hi(0, "DiffText",     { fg = c.blue,   bg = "NONE", bold = true })
      hi(0, "Added",        { fg = c.green })
      hi(0, "Changed",      { fg = c.yellow })
      hi(0, "Removed",      { fg = c.red })

      -- ── Misc UI ──────────────────────────────────────────────────────────────
      hi(0, "WinSeparator",    { fg = c.surface1 })
      hi(0, "VertSplit",       { fg = c.surface1 })
      hi(0, "NonText",         { fg = c.surface1 })
      hi(0, "Whitespace",      { fg = c.surface1 })
      hi(0, "SpecialKey",      { fg = c.surface1 })
      hi(0, "EndOfBuffer",     { fg = "NONE" })
      hi(0, "MatchParen",      { fg = c.peach, bold = true, underline = true })
      hi(0, "ModeMsg",         { fg = c.text,  bold = true })
      hi(0, "MsgArea",         { fg = c.text })
      hi(0, "MoreMsg",         { fg = c.blue })
      hi(0, "ErrorMsg",        { fg = c.red })
      hi(0, "WarningMsg",      { fg = c.yellow })
      hi(0, "Question",        { fg = c.blue })
      hi(0, "QuickFixLine",    { bg = c.surface0 })
      hi(0, "WildMenu",        { fg = c.base, bg = c.mauve })
      hi(0, "Title",           { fg = c.blue,    bold = true })
      hi(0, "Directory",       { fg = c.blue })
      hi(0, "Conceal",         { fg = c.overlay0 })
      hi(0, "SpellBad",        { sp = c.red,    undercurl = true })
      hi(0, "SpellCap",        { sp = c.yellow, undercurl = true })
      hi(0, "SpellRare",       { sp = c.teal,   undercurl = true })
      hi(0, "SpellLocal",      { sp = c.blue,   undercurl = true })

      -- ── Syntax ───────────────────────────────────────────────────────────────
      hi(0, "Comment",        { fg = c.overlay0, italic = true })
      hi(0, "Constant",       { fg = c.peach })
      hi(0, "String",         { fg = c.green })
      hi(0, "Character",      { fg = c.teal })
      hi(0, "Number",         { fg = c.peach })
      hi(0, "Float",          { fg = c.peach })
      hi(0, "Boolean",        { fg = c.peach,  bold = true })
      hi(0, "Identifier",     { fg = c.flamingo })
      hi(0, "Function",       { fg = c.blue,   bold = true })
      hi(0, "Statement",      { fg = c.mauve })
      hi(0, "Conditional",    { fg = c.mauve,  italic = true })
      hi(0, "Repeat",         { fg = c.mauve,  italic = true })
      hi(0, "Label",          { fg = c.mauve })
      hi(0, "Operator",       { fg = c.sky })
      hi(0, "Keyword",        { fg = c.mauve,  italic = true })
      hi(0, "Exception",      { fg = c.red })
      hi(0, "PreProc",        { fg = c.pink })
      hi(0, "Include",        { fg = c.mauve })
      hi(0, "Define",         { fg = c.mauve })
      hi(0, "Macro",          { fg = c.mauve })
      hi(0, "PreCondit",      { fg = c.mauve })
      hi(0, "Type",           { fg = c.yellow, bold = true })
      hi(0, "StorageClass",   { fg = c.yellow })
      hi(0, "Structure",      { fg = c.yellow })
      hi(0, "Typedef",        { fg = c.yellow })
      hi(0, "Special",        { fg = c.pink })
      hi(0, "SpecialComment", { fg = c.overlay2, italic = true })
      hi(0, "Tag",            { fg = c.peach })
      hi(0, "Delimiter",      { fg = c.text })
      hi(0, "Debug",          { fg = c.peach })
      hi(0, "Underlined",     { underline = true })
      hi(0, "Ignore",         { fg = c.overlay0 })
      hi(0, "Error",          { fg = c.red })
      hi(0, "Todo",           { fg = c.base, bg = c.yellow, bold = true })

      -- ── Treesitter ────────────────────────────────────────────────────────────
      hi(0, "@variable",               { fg = c.text })
      hi(0, "@variable.builtin",       { fg = c.red })
      hi(0, "@variable.parameter",     { fg = c.maroon })
      hi(0, "@variable.member",        { fg = c.lavender })
      hi(0, "@constant",               { fg = c.peach })
      hi(0, "@constant.builtin",       { fg = c.peach, bold = true })
      hi(0, "@constant.macro",         { fg = c.mauve })
      hi(0, "@module",                 { fg = c.flamingo, italic = true })
      hi(0, "@string",                 { fg = c.green })
      hi(0, "@string.escape",          { fg = c.pink })
      hi(0, "@string.special",         { fg = c.sky })
      hi(0, "@character",              { fg = c.teal })
      hi(0, "@number",                 { fg = c.peach })
      hi(0, "@boolean",                { fg = c.peach, bold = true })
      hi(0, "@float",                  { fg = c.peach })
      hi(0, "@function",               { fg = c.blue, bold = true })
      hi(0, "@function.builtin",       { fg = c.peach })
      hi(0, "@function.call",          { fg = c.blue })
      hi(0, "@function.macro",         { fg = c.teal })
      hi(0, "@function.method",        { fg = c.blue, bold = true })
      hi(0, "@function.method.call",   { fg = c.blue })
      hi(0, "@constructor",            { fg = c.sapphire })
      hi(0, "@operator",               { fg = c.sky })
      hi(0, "@keyword",                { fg = c.mauve, italic = true })
      hi(0, "@keyword.function",       { fg = c.mauve, italic = true })
      hi(0, "@keyword.operator",       { fg = c.mauve })
      hi(0, "@keyword.import",         { fg = c.mauve })
      hi(0, "@keyword.storage",        { fg = c.yellow })
      hi(0, "@keyword.repeat",         { fg = c.mauve, italic = true })
      hi(0, "@keyword.return",         { fg = c.mauve, italic = true })
      hi(0, "@keyword.exception",      { fg = c.red })
      hi(0, "@keyword.conditional",    { fg = c.mauve, italic = true })
      hi(0, "@type",                   { fg = c.yellow, bold = true })
      hi(0, "@type.builtin",           { fg = c.yellow })
      hi(0, "@type.definition",        { fg = c.yellow })
      hi(0, "@attribute",              { fg = c.pink })
      hi(0, "@property",               { fg = c.lavender })
      hi(0, "@punctuation.delimiter",  { fg = c.overlay2 })
      hi(0, "@punctuation.bracket",    { fg = c.overlay2 })
      hi(0, "@punctuation.special",    { fg = c.sky })
      hi(0, "@comment",                { fg = c.overlay0, italic = true })
      hi(0, "@comment.todo",           { fg = c.base, bg = c.yellow, bold = true })
      hi(0, "@comment.warning",        { fg = c.base, bg = c.peach,  bold = true })
      hi(0, "@comment.error",          { fg = c.base, bg = c.red,    bold = true })
      hi(0, "@comment.note",           { fg = c.base, bg = c.blue,   bold = true })
      hi(0, "@tag",                    { fg = c.mauve })
      hi(0, "@tag.attribute",          { fg = c.teal })
      hi(0, "@tag.delimiter",          { fg = c.sky })
      hi(0, "@markup.heading",         { fg = c.blue,    bold = true })
      hi(0, "@markup.italic",          { italic = true })
      hi(0, "@markup.bold",            { bold = true })
      hi(0, "@markup.underline",       { underline = true })
      hi(0, "@markup.strikethrough",   { strikethrough = true })
      hi(0, "@markup.link",            { fg = c.blue,  underline = true })
      hi(0, "@markup.link.url",        { fg = c.sky,   underline = true })
      hi(0, "@markup.raw",             { fg = c.teal })
      hi(0, "@markup.list",            { fg = c.mauve })
      hi(0, "@diff.plus",              { fg = c.green })
      hi(0, "@diff.minus",             { fg = c.red })
      hi(0, "@diff.delta",             { fg = c.yellow })

      -- ── LSP semantic tokens ───────────────────────────────────────────────────
      hi(0, "@lsp.type.class",         { fg = c.yellow, bold = true })
      hi(0, "@lsp.type.decorator",     { fg = c.flamingo })
      hi(0, "@lsp.type.enum",          { fg = c.yellow })
      hi(0, "@lsp.type.enumMember",    { fg = c.peach })
      hi(0, "@lsp.type.function",      { fg = c.blue,   bold = true })
      hi(0, "@lsp.type.interface",     { fg = c.sapphire })
      hi(0, "@lsp.type.macro",         { fg = c.teal })
      hi(0, "@lsp.type.method",        { fg = c.blue })
      hi(0, "@lsp.type.namespace",     { fg = c.flamingo, italic = true })
      hi(0, "@lsp.type.parameter",     { fg = c.maroon })
      hi(0, "@lsp.type.property",      { fg = c.lavender })
      hi(0, "@lsp.type.struct",        { fg = c.yellow })
      hi(0, "@lsp.type.type",          { fg = c.yellow })
      hi(0, "@lsp.type.typeParameter", { fg = c.teal })
      hi(0, "@lsp.type.variable",      { fg = c.text })

      -- ── Diagnostics ──────────────────────────────────────────────────────────
      hi(0, "DiagnosticError",            { fg = c.red })
      hi(0, "DiagnosticWarn",             { fg = c.yellow })
      hi(0, "DiagnosticInfo",             { fg = c.sky })
      hi(0, "DiagnosticHint",             { fg = c.teal })
      hi(0, "DiagnosticOk",              { fg = c.green })
      hi(0, "DiagnosticVirtualTextError", { fg = c.red,    bg = "NONE", italic = true })
      hi(0, "DiagnosticVirtualTextWarn",  { fg = c.yellow, bg = "NONE", italic = true })
      hi(0, "DiagnosticVirtualTextInfo",  { fg = c.sky,    bg = "NONE", italic = true })
      hi(0, "DiagnosticVirtualTextHint",  { fg = c.teal,   bg = "NONE", italic = true })
      hi(0, "DiagnosticUnderlineError",   { sp = c.red,    undercurl = true })
      hi(0, "DiagnosticUnderlineWarn",    { sp = c.yellow, undercurl = true })
      hi(0, "DiagnosticUnderlineInfo",    { sp = c.sky,    underdotted = true })
      hi(0, "DiagnosticUnderlineHint",    { sp = c.teal,   underdotted = true })
      hi(0, "DiagnosticSignError",        { fg = c.red })
      hi(0, "DiagnosticSignWarn",         { fg = c.yellow })
      hi(0, "DiagnosticSignInfo",         { fg = c.sky })
      hi(0, "DiagnosticSignHint",         { fg = c.teal })

      -- ── Git ───────────────────────────────────────────────────────────────────
      hi(0, "GitSignsAdd",    { fg = c.green })
      hi(0, "GitSignsChange", { fg = c.yellow })
      hi(0, "GitSignsDelete", { fg = c.red })

      -- ── Telescope ─────────────────────────────────────────────────────────────
      hi(0, "TelescopeNormal",         { fg = c.text,     bg = "NONE" })
      hi(0, "TelescopeBorder",         { fg = c.surface2, bg = "NONE" })
      hi(0, "TelescopePromptNormal",   { fg = c.text,     bg = "NONE" })
      hi(0, "TelescopePromptBorder",   { fg = c.mauve,    bg = "NONE" })
      hi(0, "TelescopePromptTitle",    { fg = c.base,  bg = c.mauve, bold = true })
      hi(0, "TelescopePreviewTitle",   { fg = c.base,  bg = c.green, bold = true })
      hi(0, "TelescopeResultsTitle",   { fg = c.base,  bg = c.blue,  bold = true })
      hi(0, "TelescopeSelection",      { fg = c.text,  bg = c.surface0 })
      hi(0, "TelescopeSelectionCaret", { fg = c.mauve, bg = c.surface0 })
      hi(0, "TelescopeMatching",       { fg = c.peach, bold = true })

      -- ── Neo-tree ──────────────────────────────────────────────────────────────
      hi(0, "NeoTreeNormal",       { fg = c.text,  bg = "NONE" })
      hi(0, "NeoTreeNormalNC",     { fg = c.text,  bg = "NONE" })
      hi(0, "NeoTreeEndOfBuffer",  { fg = "NONE",  bg = "NONE" })
      hi(0, "NeoTreeRootName",     { fg = c.mauve, bold = true })
      hi(0, "NeoTreeFileName",     { fg = c.text })
      hi(0, "NeoTreeFileIcon",     { fg = c.blue })
      hi(0, "NeoTreeDirectoryIcon",{ fg = c.blue })
      hi(0, "NeoTreeDirectoryName",{ fg = c.blue })
      hi(0, "NeoTreeGitAdded",     { fg = c.green })
      hi(0, "NeoTreeGitModified",  { fg = c.yellow })
      hi(0, "NeoTreeGitDeleted",   { fg = c.red })
      hi(0, "NeoTreeIndentMarker", { fg = c.surface1 })

      -- ── Which-key ─────────────────────────────────────────────────────────────
      hi(0, "WhichKey",          { fg = c.mauve })
      hi(0, "WhichKeyGroup",     { fg = c.blue })
      hi(0, "WhichKeyDesc",      { fg = c.text })
      hi(0, "WhichKeySeparator", { fg = c.surface2 })
      hi(0, "WhichKeyFloat",     { bg = "NONE" })
      hi(0, "WhichKeyBorder",    { fg = c.surface2, bg = "NONE" })

      -- ── Indent blankline / snacks indent ─────────────────────────────────────
      hi(0, "IblIndent",        { fg = c.surface0 })
      hi(0, "IblScope",         { fg = c.surface2 })
      hi(0, "SnacksIndent",     { fg = c.surface0 })
      hi(0, "SnacksIndentScope",{ fg = c.overlay0 })

      -- ── Noice ─────────────────────────────────────────────────────────────────
      hi(0, "NoiceCmdlinePopup",       { fg = c.text,  bg = "NONE" })
      hi(0, "NoiceCmdlinePopupBorder", { fg = c.mauve, bg = "NONE" })
      hi(0, "NoiceCmdlineIcon",        { fg = c.mauve })
      hi(0, "NoiceConfirm",            { fg = c.text,  bg = "NONE" })
      hi(0, "NoiceConfirmBorder",      { fg = c.mauve, bg = "NONE" })

      -- ── Trouble ───────────────────────────────────────────────────────────────
      hi(0, "TroubleNormal", { fg = c.text, bg = "NONE" })

      -- ── DAP ───────────────────────────────────────────────────────────────────
      hi(0, "DapBreakpoint",          { fg = c.red })
      hi(0, "DapBreakpointCondition", { fg = c.yellow })
      hi(0, "DapStopped",             { fg = c.green })
      hi(0, "DapBreakpointRejected",  { fg = c.surface2 })
      hi(0, "DapStoppedLine",         { bg = c.surface0 })

      -- ── Flash ─────────────────────────────────────────────────────────────────
      hi(0, "FlashBackdrop",  { fg = c.overlay0 })
      hi(0, "FlashLabel",     { fg = c.base, bg = c.mauve, bold = true })
      hi(0, "FlashMatch",     { fg = c.base, bg = c.peach })
      hi(0, "FlashCurrent",   { fg = c.base, bg = c.green })

      -- ── Illuminate ────────────────────────────────────────────────────────────
      hi(0, "IlluminatedWordText",  { bg = c.surface1 })
      hi(0, "IlluminatedWordRead",  { bg = c.surface1 })
      hi(0, "IlluminatedWordWrite", { bg = c.surface1, underline = true })

      -- ── Rainbow delimiters ────────────────────────────────────────────────────
      hi(0, "RainbowDelimiterRed",    { fg = c.red })
      hi(0, "RainbowDelimiterYellow", { fg = c.yellow })
      hi(0, "RainbowDelimiterBlue",   { fg = c.blue })
      hi(0, "RainbowDelimiterOrange", { fg = c.peach })
      hi(0, "RainbowDelimiterGreen",  { fg = c.green })
      hi(0, "RainbowDelimiterViolet", { fg = c.mauve })
      hi(0, "RainbowDelimiterCyan",   { fg = c.teal })

      -- ── Todo-comments ─────────────────────────────────────────────────────────
      hi(0, "TodoBgTODO",   { fg = c.base, bg = c.blue,   bold = true })
      hi(0, "TodoBgFIX",    { fg = c.base, bg = c.red,    bold = true })
      hi(0, "TodoBgHACK",   { fg = c.base, bg = c.yellow, bold = true })
      hi(0, "TodoBgWARN",   { fg = c.base, bg = c.peach,  bold = true })
      hi(0, "TodoBgPERF",   { fg = c.base, bg = c.mauve,  bold = true })
      hi(0, "TodoBgNOTE",   { fg = c.base, bg = c.teal,   bold = true })
      hi(0, "TodoFgTODO",   { fg = c.blue })
      hi(0, "TodoFgFIX",    { fg = c.red })
      hi(0, "TodoFgHACK",   { fg = c.yellow })
      hi(0, "TodoFgWARN",   { fg = c.peach })
      hi(0, "TodoFgPERF",   { fg = c.mauve })
      hi(0, "TodoFgNOTE",   { fg = c.teal })

      -- ── Blink.cmp ─────────────────────────────────────────────────────────────
      hi(0, "BlinkCmpMenu",            { fg = c.text,  bg = c.surface0 })
      hi(0, "BlinkCmpMenuBorder",      { fg = c.surface2, bg = "NONE" })
      hi(0, "BlinkCmpMenuSelection",   { fg = c.base,  bg = c.mauve,   bold = true })
      hi(0, "BlinkCmpLabel",           { fg = c.text })
      hi(0, "BlinkCmpLabelDeprecated", { fg = c.overlay0, strikethrough = true })
      hi(0, "BlinkCmpLabelMatch",      { fg = c.peach, bold = true })
      hi(0, "BlinkCmpKind",            { fg = c.mauve })
      hi(0, "BlinkCmpDoc",             { fg = c.text,  bg = c.surface0 })
      hi(0, "BlinkCmpDocBorder",       { fg = c.surface2, bg = "NONE" })
      hi(0, "BlinkCmpGhostText",       { fg = c.overlay0, italic = true })
      hi(0, "BlinkCmpScrollBarThumb",  { bg = c.surface2 })
      hi(0, "BlinkCmpScrollBarGutter", { bg = c.surface0 })

      -- ── Lualine (uses autocolor from theme name, but set fallback) ────────────
      hi(0, "StatusLine",   { fg = c.text, bg = "NONE" })
      hi(0, "StatusLineNC", { fg = c.surface2, bg = "NONE" })
    end,
  },
}
