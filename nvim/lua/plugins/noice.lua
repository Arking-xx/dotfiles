return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		notify = {
			enabled = true,
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				opts = {
					background_colour = "#000000",
					stages = "fade_in_slide_out",
					timeout = 3000,
				},
			}
		}
	}
}
