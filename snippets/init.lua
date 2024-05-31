-- Please place your program documentations and description comments here
--
-- :: Information
-- Author = [author-name]
-- Project Name = [project-repo-name]
-- Program Name = [executable]
--
-- :: Program
-- - Dependencies


--- Import dependency libraries/packages
--- Structure: local pkg_name = require("package.module")

--- Initialize the lua master dictionary mapping
local M = {}

--- Set the master table's default options
M.opts = {}

function M.open()
    --- When UI is opened
end

function M.setup(opts)
    --- Activate on require().setup()
end

--- Return the master configuration option/values
return M

