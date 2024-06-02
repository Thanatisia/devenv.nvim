--- Unit Test: DevEnvManage

--- Import package and libraries
local devenv = require('devenv')

--- Setup package settings
devenv.setup({
    config_filename = "config.txt",
    snippets_dir = "snippets",
})


