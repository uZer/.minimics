local function my_on_attach(bufnr)
  -- default mappings
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)

  -- override with custom mappings
  vim.keymap.set('n', 'U', api.tree.change_root_to_parent, opts('Up'))
end

-- Browse the directory with nvim-tree when opening a buffer on a directory
-- instead of a file.
local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end
  -- create a new, empty buffer
  vim.cmd.enew()
  -- wipe the directory buffer
  vim.cmd.bw(data.buf)
  -- change to the directory
  vim.cmd.cd(data.file)
  -- open the tree
  require("nvim-tree.api").tree.open()
end


return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  -- Only load plugin when running NvimTreeToggle
  cmd = "NvimTreeToggle",

  -- Disable native netrw at init
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", { silent = true, noremap = true })
  end,

  opts = {
    diagnostics = {
      enable = true,
    },
    modified = {
      enable = true,
    },
    respect_buf_cwd = true,
    filters = {
      dotfiles = false,
    },
    renderer = {
      -- root_folder_label = ":h:t/:t", -- was ":~:s?$?/..?",
      root_folder_label = function(root_cwd)
        -- Get parent directory and current directory
        local parent_dir = vim.fn.fnamemodify(root_cwd, ":h:t") -- Get parent directory name
        local current_dir = vim.fn.fnamemodify(root_cwd, ":t")  -- Get current directory name

        -- If parent directory exists, display "parent/current", else just "current"
        if parent_dir ~= "" then
          return parent_dir .. "/" .. current_dir
        else
          return current_dir
        end
      end,
      group_empty = true,
      highlight_git = true,
      icons = {
        git_placement = "after",
      }
    },
    update_focused_file = {
      enable = true,
      update_root = {
        enable = true,
      }
    },
    update_cwd = true,
    view = {
      -- signcolumn = "yes",
      -- width = 32,
    },
    on_attach = my_on_attach,
  }
}
