return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
    },

    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = {buffer = event.buf}

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', '<leader>k', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "c", -- change this to any language
            callback = function()
                vim.diagnostic.disable(0)
            end,
        })

        -- Mason setup
        require("mason").setup({
            ensure_installed = {
            },
        })

        -- Mason-lspconfig setup
        require("mason-lspconfig").setup({
            handlers = {
                -- Default handler for automatically configuring installed servers
                function(server_name)
                    require("lspconfig")[server_name].setup({}) end,

                    -- You can add custom handlers for specific servers here
                    -- For example:
                    -- tsserver = function(_, opts)
                        --   require("lspconfig").tsserver.setup(opts)
                        -- end,
                    },
                })


                local cmp = require("cmp")

                cmp.setup({
                    sources = {
                        {name = "nvim_lsp"},
                    },


                    formatting = {
                        fields = { "kind", "abbr", "menu" },
                        format = function(entry, vim_item)
                            -- Kind icons
                            -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                            vim_item.menu = ({
                                nvim_lsp = "[LSP]",
                                --nvim_lsp_signature_help = "[LSP-Signature]",
                                buffer = "[Buffer]",
                                path = "[Path]",
                            })[entry.source.name]
                            return vim_item
                        end,
                    },

                    vim.diagnostic.config({
                        virtual_text = {
                            severity = { min = vim.diagnostic.severity.ERROR },  -- only show errors
                            prefix = "-",  -- optional: symbol for virtual text
                        },
                        severity = { min = vim.diagnostic.severity.ERROR },  -- only show errors
                        signs = false,         -- removes the "W" or "H" in the sign column
                        underline = true,      -- underline only real errors
                        severity_sort = true,
                    })

                })
            end
        }
