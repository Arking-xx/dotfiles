return {
	{
		"MunifTanjim/eslint.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- load when editing JS/TS files
		config = function()
			require("eslint").setup({
				bin = "eslint", -- or "eslint_d" if you use eslint_d for speed
				code_actions = {
					enable = true,
					apply_on_save = {
						enable = true,
						types = { "problem", "suggestion", "layout" },
					},
				},
				diagnostics = {
					enable = true,
					report_unused_disable_directives = false,
					run_on = "type",
				},
			})
		end,
	},
}
