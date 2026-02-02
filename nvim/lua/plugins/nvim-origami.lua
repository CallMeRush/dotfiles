return {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {
        foldKeymaps = {
            setup = false,
            closeOnlyOnFirstColumn = true, -- does not work
        },
    }, -- needed even when using default config

	-- recommended: disable vim's auto-folding
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
}

