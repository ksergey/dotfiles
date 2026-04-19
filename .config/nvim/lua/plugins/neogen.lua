return {
    "danymat/neogen",
    config = function()
        require('neogen').setup({
            languages = {
                ['cpp.doxygen'] = require('neogen.configurations.cpp')
            }
        })
    end,
}
