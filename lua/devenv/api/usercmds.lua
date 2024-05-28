-- Create User Commands

--- Import dependency libraries/packages
local ui = require("devenv.ui")

--- Initialize the lua master dictionary mapping
local M = {}

--- Set the master table's default options
M.opts = {}

--- Set the script's setup function (Optional)
function M.setup(opts)
    M.opts = opts
end

--- Define and Create User Commands
vim.api.nvim_create_user_command("DevEnvCreate",
    function(opts)
        --- Check if options is empty
        if next(opts) ~= nil then
            print("Arguments: " .. tostring(opts))
        end

        -- Open popup menu and get the selected file type
        local file_type = ui.get_file_type(opts)

        -- Check if a file type is selected
        if file_type ~= nil then
            -- Process selected file type
            print("Selected File Type: " .. file_type)

            -- Statements
        end
    end, {
        nargs = "*",
    }
)

--- Return the script's master configuration option/values
return M

