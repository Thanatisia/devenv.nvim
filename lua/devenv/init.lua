-- Development Environment Manager
-- :: Information
-- - Dependencies
--     - plenary

--- Import dependency libraries/packages
local config = require("devenv.config")
-- local ui = require("devenv.ui")
local usercmds = require("devenv.api.usercmds")

--- Initialize the lua master dictionary mapping
local M = {}

--- Set the master table's default options
M.opts = {}

function M.open()
    --- When UI is opened
end

function M.setup(opts)
    --- Activate on require().setup()
    config.setup(opts)
    usercmds.setup(opts)
end

--- Return the master configuration option/values
return M

