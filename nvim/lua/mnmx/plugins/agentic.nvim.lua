return {
  "carlos-algms/agentic.nvim",

  --- @type agentic.PartialUserConfig
  opts = {
    -- Any ACP-compatible provider works.
    -- Built-in:
    -- "auggie-acp"
    -- "claude-agent-acp"
    -- "cline-acp"
    -- "codex-acp"
    -- "copilot-acp"
    -- "cursor-acp"
    -- "gemini-acp"
    -- "goose-acp"
    -- "mistral-vibe-acp"
    -- "opencode-acp"
    provider = "opencode-acp",

    --- @type agentic.PartialUserConfig
    opts = {
      diff_preview = {
        enabled = true,
        layout = "inline", -- "split" or "inline"
        center_on_navigate_hunks = true,
      },
    },
  },
  keys = {
    {
      "<leader>at",
      function()
        require("agentic").toggle()
      end,
      mode = { "n", "v" },
      desc = "Toggle Agentic Chat",
    },
    {
      "<leader>af",
      function()
        require("agentic").add_selection_or_file_to_context()
      end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic to Context",
    },
    {
      "<leader>an",
      function()
        require("agentic").new_session()
      end,
      mode = { "n", "v" },
      desc = "New Agentic Session",
    },
    {
      "<leader>ar",
      function()
        require("agentic").restore_session()
      end,
      desc = "Agentic Restore session",
      silent = true,
      mode = { "n", "v" },
    },
    {
      "<leader>ad",
      function()
        require("agentic").add_current_line_diagnostics()
      end,
      desc = "Add current line diagnostic to Agentic",
      mode = { "n" },
    },
    {
      "<leader>aD",
      function()
        require("agentic").add_buffer_diagnostics()
      end,
      desc = "Add all buffer diagnostics to Agentic",
      mode = { "n" },
    },
  },
}
