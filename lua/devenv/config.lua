-- Configurations library

--- Initialize variables
local M = {}
local defaults = {}

--- Set master table as default options
M.opts = {
    config_filename = "config.txt",
    extensions = {
        --- Place your file extensions here
        "c", --- C
        "cpp", --- C++
        "py", --- Python
        "js", --- Javascript
    },
}

function M.setup(opts)
    --- Check if options are provided
    if opts ~= nil then
        --- Initialize options and set the options to the master table
        --- M.opts = vim.tbl_deep_extend("force", {}, defaults, opts or {})

        --- Iterate through the options table/dictionary (Key-value mappings) and obtain the key-values to replace the default
        for k,v in pairs(opts) do
            --- Update/Modify the keys found in the default options with the values of the provided options by the custom configuration file
            M.opts[k] = v
        end
    end
end

--- Perform initial setup on import/source
M.setup()

--- Return the master configuration option/values
return M

