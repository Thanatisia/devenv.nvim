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

--- Open file and Import menu options from file
--- comment
--- @param file_name any
--- @return table
function M.import_file_contents(file_name)

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

--- Open file (Create if it doesnt exist) and Write some contents if provided
--- comment
--- @param file_name any
--- @param contents any
function M.create_new_file(file_name, contents)
    --- Initialize Variables

    --- Null Validation: Check if file name is provided
    if file_name ~= nil then
        --- Open file (in read mode) for reading
        local file = io.open(file_name, "w")

        --- Null Validation: Check if file was opened properly
        if file then
            --- Write lines into the file
            file:write(contents)

            --- Close file after usage
            file:close()
        else
            print("Error opening File Name: [" .. file_name .. "]")
        end
    else
        print("File Name not provided")
    end
end

--- Check if file exists
function M.check_file_exists(file_name)
    --- Initialize Variables
    local token = false

    --- Null Validation: Check if file name is provided
    if file_name ~= nil then
        --- Open file (in read mode) for reading
        local file = io.open(file_name, "r")

        --- Null Validation: Check if file was opened properly
        if file ~= nil then
            --- File Exists, set as true
            token = true

            --- Close file after usage
            io.close(file)
        end
    end

    return token
end

--- Return the script's master configuration option/values
return M

