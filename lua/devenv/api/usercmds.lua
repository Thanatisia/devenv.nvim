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
    function(opts, file_type)
        --- Declare/Initialize Variables
        local async_res = {} --- Initialize an asynchronous results table

        --- Check if options is empty
        if next(opts.fargs) ~= nil then
            print("Arguments: " .. table.concat(opts.fargs, " "))
        end

        --- Define asynchronous coroutine function
        local function coroutine_get_file_type()
            -- Open popup menu, select the file type of the user's choice and return the yield
            local result = ui.get_file_type(opts)

            --- Yield the result and return to the caller when the coroutine is resumed
            async_res.result = result
        end

        --- Create a new coroutine for handling asynchronous function synchronously
        local co = coroutine.create(coroutine_get_file_type)

        --- Start the coroutine after the asynchronous operation is completed, and to wait for the user selection to complete.
        --- WHY ON EARTH IS plenary.popup() ASYNCHRONOUS??????????
        local success, error_message = coroutine.resume(co)

        --- Check for errors in coroutine startup
        if not success then
            print("Coroutine startup error: " .. error_message)
            return
        end

        --- Get current coroutine status
        local co_status = coroutine.status(co)
        print("Status: " .. co_status)

        --- Check if current coroutine is dead or alive
        if co_status ~= "dead" then
            --- Coroutine is not dead (Suspended/Running)
            --- Suspend execution until the callback resumes it
            coroutine.yield()
        end

        --- Attempt to resume and return the status and results if the asynchronous routine operation has ended
        --- local status, result = coroutine.resume(co)
        print("Asynchronous Result: " .. tostring(async_res.result))

        --- Retrieve the result
        file_type = async_res.result

        -- Check if a file type is selected
        if file_type then
            -- Process selected file type
            print("Selected File Type: " .. tostring(file_type))

            -- Statements
        end
    end, {
        nargs = "*",
    }
)

--- Return the script's master configuration option/values
return M

