require "conf"
if vim.g.neovide then
  vim.g.neovide_fullscreen = true
  vim.o.guifont = "JetBrainsMono Nerd Font:h15"
end
vim.opt.shell = "powershell"
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

