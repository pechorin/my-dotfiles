-- Copy from https://github.com/rgroli/other.nvim?tab=readme-ov-file

local rails_alternative_targets = {
	{ context = "model",      target = "/app/models/%1.rb",                   transformer = "singularize" },
	{ context = "controller", target = "/app/controllers/**/%1_controller.rb" },
	{ context = "view",       target = "/app/views/%1/*.html*" },
	{ context = "view",       target = "/app/views/%1/*.html*",               transformer = "singularize" },
	{ context = "channel",    target = "/app/channels/**/%1_channel.rb" },
	{ context = "mailer",     target = "/app/mailers/%1_mailer.rb" },
	{ context = "serializer", target = "/app/serializers/%1_serializer.rb" },
	{ context = "mailer",     target = "/app/mailers/%1_mailer.rb" },
	{ context = "service",    target = "/app/services/%1_service.rb" },
	{ context = "worker",     target = "/app/workers/**/%1_worker.rb" },
	{ context = "factories",  target = "/spec/factories/%1.rb",               transformer = "pluralize" },
}

require("other-nvim").setup({
    mappings = {
        -- builtin mappings
        -- "livewire",
        -- "angular",
        -- "laravel",
        "rails",
        "golang",
        -- "python",
        -- "react",
        "rust",
        "elixir",
        -- custom mappings

        -- {
        --   pattern = "/app/interactions/(.*)/.*.rb",
        --   target = rails_alternative_targets,
        --   context = 'interaction'
        -- },

        -- {
        --     pattern = "/path/to/file/src/app/(.*)/.*.ext$",
        --     target = "/path/to/file/src/view/%1/",
        --     transformer = "lowercase"
        -- }
    },
    transformers = {
        -- defining a custom transformer
        lowercase = function (inputString)
            return inputString:lower()
        end
    },
    style = {
        -- How the plugin paints its window borders
        -- Allowed values are none, single, double, rounded, solid and shadow
        border = "solid",

        -- Column seperator for the window
        seperator = "|",

        -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
        width = 0.7,

        -- min height in rows.
        -- when more columns are needed this value is extended automatically
        minHeight = 2
    },
})

vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>:Other<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ltn", "<cmd>:OtherTabNew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>:OtherSplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lv", "<cmd>:OtherVSplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lc", "<cmd>:OtherClear<CR>", { noremap = true, silent = true })

-- Context specific bindings
vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>:Other test<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>:Other scss<CR>", { noremap = true, silent = true })
