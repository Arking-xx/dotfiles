return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"eslint",
				"ts_ls",
				"html",
				"emmet_ls",
				"pyright",
				"tailwindcss",
			},
		})

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Get default capabilities from cmp-nvim-lsp
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Common on_attach function for all LSP servers
		local on_attach = function(client, bufnr)
			-- Key mappings for LSP functionality
			local opts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		end

		-- Tailwind CSS LSP
		vim.lsp.config.tailwindcss = {
			cmd = { 'tailwindcss-language-server', '--stdio' },
			filetypes = {
				"html",
				"css",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- Lua LSP
		vim.lsp.config.lua_ls = {
			cmd = { 'lua-language-server' },
			filetypes = { 'lua' },
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}

		-- Python LSP
		vim.lsp.config.pyright = {
			cmd = { 'pyright-langserver', '--stdio' },
			filetypes = { 'python' },
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- ESLint LSP
		vim.lsp.config.eslint = {
			cmd = { 'vscode-eslint-language-server', '--stdio' },
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)

				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						if vim.fn.exists(":EslintFixAll") > 0 then
							vim.cmd("EslintFixAll")
						end
					end,
				})
			end,
			settings = {
				workingDirectory = { mode = "auto" },
				codeActionOnSave = {
					enable = true,
					mode = "all",
				},
				format = false,
				quiet = false,
			},
		}

		-- TypeScript LSP
		vim.lsp.config.ts_ls = {
			cmd = { 'typescript-language-server', '--stdio' },
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- HTML LSP
		vim.lsp.config.html = {
			cmd = { 'vscode-html-language-server', '--stdio' },
			filetypes = { "html", "templ" },
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = {
				configurationSection = { "html", "css", "javascript", "typescript" },
				embeddedLanguages = {
					css = true,
					javascript = true,
					typescript = true
				},
				provideFormatter = true
			}
		}

		-- Emmet LSP
		vim.lsp.config.emmet_ls = {
			cmd = { 'emmet-ls', '--stdio' },
			filetypes = {
				"html",
				"css",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = {
				html = {
					options = {
						["output.selfClosingStyle"] = "xhtml"
					},
				},
				typescript = {},
				-- javascript = {
				-- 	options = {
				-- 		["output.selfClosingStyle"] = "xhtml"
				-- 	},
				-- },
				jsx = {
					options = {
						["output.selfClosingStyle"] = "xhtml",
						["markup.attributes"] = {
							["class*"] = "className",
							["for"] = "htmlFor"
						}
					}
				},
				-- typescriptreact = {
				-- 	options = {
				-- 		["output.selfClosingStyle"] = "xhtml"
				-- 	},
				-- },
				-- javascriptreact = {
				-- 	options = {
				-- 		["output.selfClosingStyle"] = "xhtml"
				-- 	},
				-- },
			}
		}



		-- Global diagnostics configuration
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				-- Truncate long virtual text messages
				format = function(diagnostic)
					local message = diagnostic.message
					if message:match("^eslint:") then
						message = message:gsub("^eslint:", "")
					end
					-- Limit virtual text to 80 characters
					if #message > 80 then
						return message:sub(1, 77) .. "..."
					end
					return message
				end,
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				}
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = true, -- Allow focusing to scroll through long messages
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
				wrap = true, -- Enable text wrapping in float window
				max_width = 80, -- Set maximum width for better readability
				max_height = 20, -- Limit height so it doesn't take entire screen
			},
		})

		-- Add keymaps for better diagnostic navigation and viewing
		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic in floating window' })
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
		vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
	end,

}
