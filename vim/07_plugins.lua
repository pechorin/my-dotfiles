require('overseer').setup({})
require("fidget").setup({})
require('diagflow').setup({ padding_top = 5, text_align = 'left' })
require("scrollbar").setup()

require('mini.surround').setup({})
require('mini.ai').setup({})
require('mini.cursorword').setup({})

-- require("snippets").setup({
--   create_cmp_source = true,
--   friendly_snippets = true
-- })

require("nvim-autopairs").setup({
  check_ts = true
})

require('eyeliner').setup({
  highlight_on_key = true, -- show highlights only after keypress dim = false              -- dim all other characters if set to true (recommended!)
})

require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true, virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000, ignore_whitespace = false, virt_text_priority = 100,
  },
})

-- quickfix
vim.cmd [[
  packadd cfilter
]]

-- do not hl cursor in term
vim.cmd [[
  hi CursorLine cterm=NONE
]]

-- zsh
vim.opt.shell = '/bin/zsh -l'

-- fzf
-- vim.cmd [[
--   set rtp+=/usr/local/opt/fzf
-- ]]

-- ripgrep
vim.opt.grepprg = 'rg --vimgrep --smart-case'
vim.opt.grepformat = '%f:%l:%c:%m'

-- Grug-far search
require('grug-far').setup({
  -- there are no required options atm
  -- engine = 'ripgrep' is default, but 'astgrep' can be specified
})

require("which-key").setup({
  preset = 'helix',
  triggers = {
    { "<auto>", mode = "nixsotc" },
    { "a", mode = { "n", "v" } },
  },
  notify=false
})

-- require('which-key.health').setup({ notify = false })
require('which-key').add({
  { '<leader>e', group = 'Colors / Vim config' },
  { '<leader>g', group = 'Git' },
})

-- fzf-lua
require("fzf-lua").setup({
  winopts = {
    -- border = 'solid',
    border = 'double',
    backdrop = 100,

    preview = {
      border = 'solid'
    }
  }
})

-- require("cutlass").setup({
-- })

require('fzf-lua').register_ui_select()

require('mtoc').setup({})


-- Formatting
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
    json = { "jq" }
  },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })


require("herdr-nvim").setup({
  prefix = "<leader>h",     -- keymap prefix
  keymaps = true,           -- set false to define your own
  clear_after_send = true,  -- comments are ephemeral by design
})
