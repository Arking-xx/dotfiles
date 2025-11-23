return {
	-- Tailwind CSS colorizer
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
			},
		},
	},
	-- Tailwind CSS completion colorizer
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		config = true,
	},
}
