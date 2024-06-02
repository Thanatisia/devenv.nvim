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

--- Scans a directory and returns all files in the directory
--- comment
--- @param dir_path any
--- @return table
function M.scandir(dir_path)
    --- Initialize Variables
    local i = 0
    local res_table = {}
    local rc = nil
    local cmd_ls = "ls -a" .. " " .. '"' .. dir_path .. '"'

    --- Check if directory exists
    if M.check_dir_exists(dir_path) then
        --- Path does not exists

        --- Open (sub)process pipe to execute a command and Create the directory
        local proc = io.popen(cmd_ls)

        --- Check if process is opened properly
        if proc ~= nil then
            --- Statements here

            --- Obtain all lines in the process pipe stream
            local proc_stdout_lines = proc:lines()

            --- Iterate/Loop through all lines in the standard stream
            for f_name in proc_stdout_lines do
                --- Check if is '.' or '..'
                if (f_name ~= ".") and (f_name ~= "..") then
                    --- Is not either
                    --- Increment the index (Lua is 1-indexed)
                    i = i+1

                    --- Set the current file name to the results table
                    res_table[i] = f_name
                end
            end

            --- Close pipe after usage and return the exit/return/result status code
            rc = proc:close()
        end
    end

    --- Return
    return res_table
end

--- Return the script's master configuration option/values
return M

