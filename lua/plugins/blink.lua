vim.pack.add({
    "https://github.com/Saghen/blink.lib",
    "https://github.com/Saghen/blink.cmp",
})


local cmp = require("blink.cmp")
cmp.build():wait(60000)

cmp.setup({
    appearance = {
        use_nvim_cmp_as_default = false,
    },
    completion = {
        trigger = {
            show_on_blocked_trigger_characters = { "\n", "\t" },
        },
        menu = {
            border = "rounded",
            max_height = 15,
            draw = {
                components = {
                    detail = {
                        width = { max = 30 },
                        text = function(ctx)
                            return ctx.item.detail or ""
                        end,
                        highlight = "BlinkCmpLabelDescription",
                    },
                },
                columns = { { "label" }, { "detail" } },
            },
        },
        documentation = {
            auto_show = false,
        },
        list = {
            selection = { preselect = false, auto_insert = false },
        },
    },
    signature = { enabled = false },
})


