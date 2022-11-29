local ok, neo_tree = pcall(require, "neo-tree")
if not ok then return end

vim.g.neo_tree_remove_legacy_commands = 1
neo_tree.setup({
    close_if_last_window = true,
    window = {
        width = 30,
        mappings = {
            ["Z"] = "expand_all_nodes",
        }
    },
})

