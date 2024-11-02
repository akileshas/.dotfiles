return {
    'nvim-treesitter/playground',
    config = function()
        local keymap = vim.keymap
        keymap.set('n', '<leader>ts', '<cmd>TSPlaygroundToggle<CR>', { desc = 'Toggle Treesitter Playground' })  
    end,
}
