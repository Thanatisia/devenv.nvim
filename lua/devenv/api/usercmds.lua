-- Create User Commands

--- Import dependency libraries/packages
local ui = require("devenv.ui")
local fileio = require("devenv.io.files") --- File I/O Processing
local dir = require("devenv.io.directory") --- Directories I/O Processing
local utils = require("devenv.utils")

--- Initialize the lua master dictionary mapping
local M = {}

--- Set the master table's default options
M.opts = {}

--- Set the script's setup function (Optional)
function M.setup(opts)
    M.opts = opts
    M.opts.ui = ui.setup(opts)
    fileio.setup(opts)
    dir.setup(opts)
    utils.setup(opts)
end

--- Define and Create User Commands
vim.api.nvim_create_user_command("DevEnvCreate",
    function(opts)
        --- Declare/Initialize Variables

        --- Create a new coroutine for handling asynchronous function synchronously
        local co = coroutine.create(function()
            --- Check if options is empty
            if next(opts.fargs) ~= nil then
                print("Arguments: " .. table.concat(opts.fargs, " "))
            end

            -- Open popup menu, select the file type of the user's choice and return the yield/result through the callback function as an elevator back up to the caller
            local file_type = ui.get_file_type(opts)

            -- Check if a file type is selected
            if file_type then
                -- Process selected file type
                print("Selected File Type: " .. tostring(file_type))

                -- Statements

                --- Create snippets directory if does not exists
                local dir_name = "out"
                local status = dir.create_new_dir(dir_name)

                print("Creating new output directory [" .. dir_name .. "]: " .. tostring(status))

                --- Design the new file properties
                local new_filename = "main" .. "." .. file_type
                local full_filepath = dir_name .. utils.path_separator .. new_filename

                --- Create new file
                print("Create new file: " .. tostring(full_filepath))
                fileio.create_new_file(full_filepath, "")

                --- Check if file is created
                local file_exists = fileio.check_file_exists(full_filepath)
                print("File Exists: " .. tostring(file_exists))
                print("Creating new source file [" .. tostring(full_filepath) .. "] of type [" .. tostring(file_type) .. "]: " .. tostring(file_exists))
            end
        end)

        --- Start the coroutine after the asynchronous operation is completed, and to wait for the user selection to complete.
        --- WHY ON EARTH IS plenary.popup() ASYNCHRONOUS??????????
        local success, message = coroutine.resume(co)

        --- Check if coroutine ran successfully
        if not success then
            error("Coroutine error: " .. message)
        end
    end, {
        nargs = "*",
    }
)

--- Return the script's master configuration option/values
return M

