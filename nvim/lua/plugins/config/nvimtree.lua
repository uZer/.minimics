-- disable netrw before loading the plugin to prevent race conditions
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local config = {
  diagnostics = {
    enable = true,
  },
  respect_buf_cwd = true,
  filters = {
    dotfiles = false,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      git_placement = "after",
    }
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  update_cwd = true,
  view = {
    mappings = {
      list = {
        { key = "U", action = "dir_up" },
      },
    },
    -- signcolumn = "yes",
    width = 32,
  },
}

vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

require("nvim-tree").setup(config)
