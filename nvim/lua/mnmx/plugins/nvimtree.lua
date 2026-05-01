local function my_on_attach(bufnr)
  -- default mappings
  local api = require("nvim-tree.api")
  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end
  api.map.on_attach.default(bufnr)

  -- override with custom mappings
  vim.keymap.set("n", "U", api.tree.change_root_to_parent, opts("Up"))

  -- helper to get absolute path
  local function get_node_path()
    local node = api.tree.get_node_under_cursor()
    if not node then
      return nil
    end
    return node.absolute_path
  end

  -- git add
  vim.keymap.set("n", "ga", function()
    local path = get_node_path()
    if not path then
      return
    end
    vim.fn.system({ "git", "add", path })
    print("git add " .. path)
  end, opts("Git add"))

  -- git reset
  vim.keymap.set("n", "gA", function()
    local path = get_node_path()
    if not path then
      return
    end
    vim.fn.system({ "git", "reset", path })
    print("git reset " .. path)
  end, opts("Git reset"))

  -- git restore
  vim.keymap.set("n", "gR", function()
    local path = get_node_path()
    if not path then
      return
    end
    vim.fn.system({ "git", "restore", path })
    print("git reset " .. path)
  end, opts("Git reset"))
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
  "nvim-tree/nvim-tree.lua",
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
    filters = {
      dotfiles = false,
    },
    renderer = {
      -- root_folder_label = ":h:t/:t", -- was ":~:s?$?/..?",
      root_folder_label = function(root_cwd)
        -- Get parent directory and current directory
        local parent_dir = vim.fn.fnamemodify(root_cwd, ":h:t") -- Get parent directory name
        local current_dir = vim.fn.fnamemodify(root_cwd, ":t") -- Get current directory name

        -- If parent directory exists, display "parent/current", else just "current"
        if parent_dir ~= "" then
          return parent_dir .. "/" .. current_dir
        else
          return current_dir
        end
      end,
      group_empty = true,
      highlight_git = "name",
      highlight_opened_files = "name",
      icons = {
        git_placement = "after",
      },
    },
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = {
        enable = true,
      },
    },
    update_cwd = true,
    view = {
      -- signcolumn = "yes",
      width = 32,
    },
    on_attach = my_on_attach,
  },
}
