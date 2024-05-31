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

    --- Check if directory exists
    if not M.check_dir_exists(dir_name) then
        --- Path does not exists
        --- Create directory
        os.execute("mkdir" .. " " .. dir_name)
    end

    token = M.check_dir_exists(dir_name)

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

