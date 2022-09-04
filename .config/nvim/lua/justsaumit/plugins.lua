local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save (:w) the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out!
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

--Actual good stuff
--Install all your plugins here
return packer.startup(function(use)
--Necessities
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
--TreeSitter
    use {'nvim-treesitter/nvim-treesitter',run = ':TSUpdate'}
--ColorSchemes
    use "folke/tokyonight.nvim"
    use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
--Web-devicons
    use "kyazdani42/nvim-web-devicons"
--Lualine
    use {'nvim-lualine/lualine.nvim',requires = { 'kyazdani42/nvim-web-devicons', opt = true }}
--Bufferline
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
