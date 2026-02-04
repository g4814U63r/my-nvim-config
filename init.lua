vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- NOTE: require order is important
require("input")
require("options")
require("autocmds")
require("lazy/lazyInit")
require("lazy").setup({ { import = "lazy/plugins" } }, require("lazy/options"))

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--[[
    HELP + DOCS:
    https://learnxinyminutes.com/docs/lua/
    https://neovim.io/doc/user/lua-guide.html
    :help lua-guide
    :help
    "<space>sh" to [s]earch the [h]elp documentation,
    I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings, plugins or Neovim features used in Kickstart.
--]]
