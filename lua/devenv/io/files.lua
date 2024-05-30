-- I/O Processing and File Handling module

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
function M.import_file_contents(file_name)
    --- Open file and Import menu options from file

    --- Initialize Variables
    local opts = {}

    --- Null Validation: Check if file name is provided
    if file_name ~= nil then
        --- Open file (in read mode) for reading
        local file = io.open(file_name, "r")

        --- Null Validation: Check if file was opened properly
        if file then
            --- Obtain the file contents
            local file_contents = file:lines()

            --- Iterate through the file contents and insert into table (dictionary/key-value mappings)
            for line in file_contents do
                --- Insert the current line into the options table
                table.insert(opts, line)
            end
        else
            print("Error opening File Name: [" .. file_name .. "]")
        end
    else
        print("File Name not provided")
    end

    --- Return the opts table to the plugin lifetime
    return opts
end

--- Return the script's master configuration option/values
return M

