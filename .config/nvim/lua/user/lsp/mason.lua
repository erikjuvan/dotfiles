local servers = {
    "clangd",
}

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

require("mason").setup(settings)

require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,

    -- NEW RECOMMENDED STYLE
    handlers = {
        function(server)
            local opts = {
                on_attach = require("user.lsp.handlers").on_attach,
                capabilities = require("user.lsp.handlers").capabilities,
            }

            -- If you have server-specific config
            local ok, conf = pcall(require, "user.lsp.settings." .. server)
            if ok then
                opts = vim.tbl_deep_extend("force", opts, conf)
            end

            require("lspconfig")[server].setup(opts)
        end,
    },
})
