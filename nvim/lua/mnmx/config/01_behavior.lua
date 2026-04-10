--
-- Behaviour options 
--

-- loglevel
vim.lsp.log.set_level("ERROR")

-- Show special chars
vim.opt.list = true
vim.opt.listchars = {
  tab = "│ ",
  trail = "·",
  nbsp = "+",
}

-- Indentation and tabulations
vim.opt.tabstop = 2 -- a tab is two spaces
vim.opt.shiftwidth = 2 -- indentation is two spaces
vim.opt.expandtab = true -- no tab char in the files, use spaces
vim.opt.autoindent = true -- keep current indentation after pressing <cr>
vim.opt.smartindent = true -- indent accordingly to the syntax
vim.opt.smarttab = true -- indent by shiftwidth spaces when pressing tab

-- Folding and Conceal
vim.opt.foldenable = false -- disable folding by default

-- Search
vim.opt.hlsearch = true -- highlight search patterns
vim.opt.incsearch = true -- go to matches when searching
vim.opt.ignorecase = true -- ignore case in search pattern
vim.opt.smartcase = true -- check case if the pattern contains uppercase chars

-- Copy / Paste settings
-- My terminal is alacritty now. It doesn't support runtime capability detection
-- (the XTGETTCAP sequence) so Neovim can't tell that the terminal supports it.
-- Because of that I get a clipboard: No provider error when I try to copy to "+
-- register. In order to prevent this, I enforce the usage of osc52 clipboard
-- https://www.reddit.com/r/neovim/comments/1d6wreh/tips_for_debugging_osc_52_not_detected_in_neovim/
--
-- To paste from terminal, use shift+insert (pasteSelection).
-- To copy to selection/primary, use "+y or Y (Yy for full line)
if vim.fn.has("clipboard") == 0 then
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "osc52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = function()
        return { {}, "v" }
      end,
      ["*"] = function()
        return { {}, "v" }
      end,
    },
  }
end

-- Spell
vim.opt.spelllang = "en_us,fr"
vim.opt.spell = false -- enable spell check with <leader>ss

-- Other
vim.opt.fileformats = { "unix", "dos" } -- use Unix first
vim.opt.textwidth = 80 -- for `gq` and linebreak text at 80 columns when typing
vim.opt.scrolloff = 8 -- scroll when at n lines from the borders of the buffer
vim.opt.sidescrolloff = 8
vim.opt.swapfile = false -- reduce pollution, save the planet
vim.opt.wildignore:append({ "*.o", "*.obj", "*~", "*.pyc" }) -- ignore some files
vim.opt.wildignorecase = true
vim.opt.inccommand = "split" -- live preview of substitutions

-- Filetype specific: fix indentation and remove tabs
local set_indent_group = vim.api.nvim_create_augroup("setIndent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = set_indent_group,
  pattern = {
    "go",
    "make",
  },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

vim.filetype.add({
  pattern = {
    [".*%.str"] = "javascript", -- strudel
    [".*%.hcl"] = "hcl",
    [".*%.libjsonnet"] = "jsonnet",
    [".*%.tf"] = "terraform",
    [".*%.tfstate"] = "json",
    [".*%.tfstate.backup"] = "json",
    [".*%.tfvars"] = "terraform",
    [".*/playbooks/.*%.yaml"] = "yaml.ansible",
    [".*/playbooks/.*%.yml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.yaml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.yml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.yaml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.yml"] = "yaml.ansible",
    [".gitlab-ci.yaml"] = "yaml.gitlab",
    [".gitlab-ci.yml"] = "yaml.gitlab",
    [".terraform.rc"] = "hcl",
    [".terraformrc"] = "hcl",
    ["ansible/.*%.yml"] = "yaml.ansible",
    [".*%.kicad_sch"] = "lisp",
    [".*%.kicad_pcb"] = "lisp",
    [".*%.kicad_sym"] = "lisp",
    [".*%.kicad_prl"] = "json",
    [".*%.kicad_pro"] = "json",
  },
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.cmd('normal! g`"')
    end
  end,
})
