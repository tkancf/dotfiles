return {
    'hrsh7th/nvim-automa',
    opts = function()
        local automa = require('automa')
        return {
            mapping = {
                ['.'] = {
                    queries = {
                        automa.query_v1({ '!n(h,j,k,l)+' }),
                    },
                },
            },
        }
    end,
}
