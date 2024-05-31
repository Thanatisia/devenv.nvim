-- I/O Processing and Directories Handling module

--- Import dependency libraries/packages

--- Initialize the lua master dictionary mapping
local M = {}

--- Set the master table's default options
M.opts = {}

--- Set the script's setup function (Optional)
function M.setup(opts)
    M.opts = opts
end

--- Declare functions here

--- Create a new directory
--- comment
--- @param dir_name any
--- @return boolean
function M.create_new_dir(dir_name)
    --- Initialize Variables
    local token = false
    local rc = nil
    local cmd_to_exec = "mkdir" .. " " .. dir_name --- command string

    --- Check if directory exists
    if not M.check_dir_exists(dir_name) then
        --- Path does not exists

        --- Open (sub)process pipe to execute a command and Create the directory
        local proc = io.popen(cmd_to_exec)

        --- Check if process is opened properly
        if proc ~= nil then
            --- Statements here

            --- Close pipe after usage and return the exit/return/result status code
            rc = proc:close()
        end
    end

    --- token = M.check_dir_exists(dir_name)
    --- Check if result is 0 (Success) or > 0 (Error)
    if rc == 0 then
        token = true
    end

    return token
end

--- Check if directory exists
function M.check_dir_exists(dir_name)
    --- Initialize Variables
    local token = false

    --- Null Validation: Check if file name is provided
    if dir_name ~= nil then
        --- Check if directory exists
        if M.exists(dir_name .. "/") then
            --- Path exists
            token = true
        end
    end

    return token
end

function M.exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

--- Return the script's master configuration option/values
return M

