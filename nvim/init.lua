--[[
 _ _ _  ,  _ _  ,  _ _ _  ,  _, (
/ / / /_(_/ / /_(_/ / / /_(_(__/_)_

  An opinionated neovim configuration.

  Complaints:
  https://github.com/uZer/.minimics

  Requirements:
  - neovim >= 0.8.0

  Requirements (NewGame+):
  - A patched Nerd Font for your terminal or ginit.vim
  - [plugin: pywal16.nvim] python wal, pywal, pywal16, or variants
  - [plugin: mason.nvim] https://github.com/williamboman/mason.nvim#requirements

  This thing has been splitted into files with comments, can you believe it?

]] -----------------------------------------------------------------------------

-- require("impatient") -- cache
require("plugins")   -- plugins
require("mnmx")      -- extra config



-- Aaaand that's all. Time for some jokes!

--[[

  ########################
  # Visitors/guests book #
  ########################
  (aka. You're the 1,000,000, congrats, I have nothing better to offer)

  --------------------------------------------------
  fig. 0001: "Holly cow! Errors! Errors everywhere!"
  --------------------------------------------------
  Please remain calm and try this:

  [plugin: packer.nvim]
    Install/Update your plugins:
      :PackerSync

  [plugin: mason]
    Install all Mason dependencies all at once:
      :MasonInstallAll

  [plugin: treesitter]
    Update treesitter dependencies:
      :TSUpdate

  Restart nvim.

  [plugin: packer.nvim]
    If you need to recompile your plugins settings:
      :PackerCompile

  [plugin: impatient]
    If you need to clear the Lua cache:
      :LuaCacheClear

  Show messages:
    :messages

  If there is no hope:
  have you checked your neovim version and the requirements?


  -----------------------------------------------------
  fig. 0002: "This is disgusting and I'm feeling sick."
  -----------------------------------------------------
  No it's not. Two things you need:

  NerdFonts for your terminal
    https://www.nerdfonts.com/

  Pywal or Pywal16 to generate your colors
    https://github.com/dylanaraps/pywal or variants (pywal16...)

  If the sickness persists, I would suggest an alternative colorscheme
  and/or a general practitioner.

]]
