return {
	"3rd/image.nvim",
	opts = {
		backend = "kitty",
		integrations = {
			markdown = {
				enabled = true,
				clear_in_insert_mode = false,
				resolve_image_path = function(document_path, image_path, fallback)
					-- Define the base path of your vault with proper expansion
					local vault_base_path = vim.fn.expand("~/Desktop/obsidian-vault")
					-- For Obsidian, you typically want to look in assets/imgs
					local adjusted_path = vault_base_path .. "/" .. image_path
					-- Check if the file exists at the adjusted path
					if vim.fn.filereadable(adjusted_path) == 1 then
						print("Found image at:", adjusted_path)
						return adjusted_path
					else
						-- Try the original path as fallback
						print("Image not found at:", adjusted_path, "- trying fallback")
						return fallback(document_path, image_path)
					end
				end,
				download_remote_images = true,
				only_render_image_at_cursor = true,
				filetypes = { "markdown", "vimwiki" },
			},
			neorg = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
				filetypes = { "norg" },
			},
		},
		max_width = nil,
		max_height = nil,
		max_width_window_percentage = nil,
		max_height_window_percentage = 50,
		window_overlap_clear_enabled = false,
		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		editor_only_render_when_focused = false,
		tmux_show_only_in_active_window = false,
		hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
	},
}
