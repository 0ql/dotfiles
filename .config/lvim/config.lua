-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.leader = ";"
lvim.colorscheme = "gruvbox"

lvim.plugins = {
	{ "ellisonleao/gruvbox.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		'RaafatTurki/hex.nvim',
		config = function()
			require("hex").setup()
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup({
				suggestion = { enabled = false },
				panel = { enabled = false }
			})
		end
	},
  {
    "numToStr/Comment.nvim",
    config = function()
      require("lvim.core.comment").setup()
    end,
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    event = "User FileOpened",
    enabled = lvim.builtin.comment.active,
		commit = "e30b7f2", -- use latest version to support hyprland conf files
  },
}

-- Below config is required to prevent copilot overriding Tab with a suggestion
-- when you're just trying to indent!
local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end
local on_tab = vim.schedule_wrap(function(fallback)
	local cmp = require("cmp")
	if cmp.visible() and has_words_before() then
		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	else
		fallback()
	end
end)
lvim.builtin.cmp.mapping["<Tab>"] = on_tab

lvim.transparent_window = true
vim.opt.cursorline = false
vim.opt.expandtab = false -- convert tabs to spaces
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["d"] = '"_d'
lvim.keys.visual_mode["d"] = '"_d'

vim.cmd [[
  au BufRead,BufNewFile *.astro set filetype=astro
  au BufRead,BufNewFile *.rasi set filetype=css
  au BufRead,BufNewFile *.pamm set filetype=markdown
  au BufRead,BufNewFile *.gohtml set filetype=html
  au BufRead,BufNewFile *.inc set filetype=html
  au BufRead,BufNewFile *.md LvimToggleFormatOnSave
  inoremap kj <C-\><C-n>
  inoremap jk <C-\><C-n>
  tnoremap jk <C-\><C-n>
  tnoremap kj <C-\><C-n>
	command! TZ term zsh
]]

vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
	pattern = { "*.hl", "hypr*.conf" },
	callback = function(event)
		-- print(string.format("starting hyprls for %s", vim.inspect(event)))
		vim.lsp.start {
			name = "hyprlang",
			cmd = { "hyprls" },
			root_dir = vim.fn.getcwd(),
		}
	end
})
