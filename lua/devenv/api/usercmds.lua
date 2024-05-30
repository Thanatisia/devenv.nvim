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
    M.opts.ui = ui.setup(opts)
end

--- Define and Create User Commands
vim.api.nvim_create_user_command("DevEnvCreate",
    function(opts)
        --- Declare/Initialize Variables

        --- Check if options is empty
        if next(opts.fargs) ~= nil then
            print("Arguments: " .. table.concat(opts.fargs, " "))
        end

        -- Open popup menu, select the file type of the user's choice and return the yield/result through the callback function as an elevator back up to the caller
        ui.get_file_type(opts, function(file_type)
            print("Asynchronous Result: " .. tostring(file_type))

            -- Check if a file type is selected
            if file_type then
                -- Process selected file type
                print("Selected File Type: " .. tostring(file_type))

                -- Statements
            end
        end)
    end, {
        nargs = "*",
    }
)

--- Return the script's master configuration option/values
return M

