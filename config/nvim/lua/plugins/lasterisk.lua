return {
    'rapan931/lasterisk.nvim',
    config = function()
        local lasterisk = require("lasterisk")
        vim.keymap.set('n', '*', function() lasterisk.search() end)
        vim.keymap.set('v', '*', function() lasterisk.search({ is_whole = false }) end)
        vim.keymap.set('n', 'g*', function() lasterisk.search({ is_whole = false }) end)
        vim.keymap.set('x', 'g*', function() lasterisk.search({ is_whole = false }) end)
    end
}
