return {
		{
				"nvim-telescope/telescope.nvim",
				tag = "0.1.8", -- pin to a stable release; remove this line to track main branch
				dependencies = {
						"nvim-lua/plenary.nvim",
								{
										"nvim-telescope/telescope-fzf-native.nvim",
										build = "make", -- requires make + a C compiler; speeds up fuzzy matching
								},
						},
				config = function()
					local telescope = require("telescope")

					telescope.setup({
						defaults = {
							prompt_prefix = "🔍 ",
							selection_caret = " ",
							layout_config = {
								horizontal = {
									preview_width = 0.55,
								},
							},
							mappings = {
								i = {
									["<C-j>"] = "move_selection_next",
									["<C-k>"] = "move_selection_previous",
									["<Esc>"] = "close",
								},
							},
						},
						extensions = {
							fzf = {
								fuzzy = true,
								override_generic_sorter = true,
								override_file_sorter = true,
								case_mode = "smart_case",
							},
						},
					})

					telescope.load_extension("fzf")
				end,
				keys = {
					{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
					{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
					{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
					{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
				},
		},
}
