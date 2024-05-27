-- Development Environment Manager
-- :: Information
-- - Dependencies
--     - plenary

--- Import dependency libraries/packages
--- local config = require("devenv.config")
--- local ui = require("devenv.ui")
local popup = require("plenary.popup") --- Popup window using plenary
local win_id --- Contains the popup window's ID

--- Initialize the lua master dictionary mapping
local M = {}
local defaults = {}

--- Set the master table's default options
M.opts = {}

--- Define the plugin's functions
function ShowMenu(opts, cb)
    --- Open/Show popup menu for user to select items
    --- Initialize Variables
    local height = 20
    local width = 30
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    --- Create popup window and return the popup window's ID
    win_id = popup.create(opts, {
        title = "MyProjects", -- "DevEnvManage",
        highlight = "MyProjectWindow", -- "File Extensions/Types",
        line = math.floor(((vim.o.lines - height)/2) - 1), --- Number of rows/lines
        col = math.floor((vim.o.columns - width)/2), --- Number of columns
        minwidth = width,   --- Minimum Width of window
        minheight = height, --- Minimum height of window
        borderchars = borderchars, --- Border characters
        callback = cb, --- Callback Event Function
    })

    --- Get buffer number from popup window
    local bufnr = vim.api.nvim_win_get_buf(win_id)

    --- Set keymapping only to the specific buffer number to close the menu
    vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", {silent=false})

    --- Return results
    return bufnr
end

function CloseMenu()
    --- Close popup menu after usage
    vim.api.nvim_win_close(win_id, true)
end

function ImportFromFile(file_name)
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
            --- print("Error opening File Name: [" .. file_name .. "]")
        end
    else
        print("File Name not provided")
    end

    --- Return the opts table to the plugin lifetime
    return opts
end

function GetFileType()
    --- Initialize Variables
    local opts = {} --- Place all your menu options here
    local config_filename = M.opts.config_filename --- Get the master table's configuration file name
    local file_extensions = M.opts.extensions --- Get the master table's file extensions list

    --- Data Validation: Check if file name is provided
    --- if config_filename ~= nil then
    if (config_filename ~= nil) or (config_filename ~= "") then
        print("Configuration Filename: " .. config_filename)

        --- Read menu contents from file
        local tmp_opts = ImportFromFile(config_filename)
        --- print("Contents imported: " .. tostring(tmp_opts))

        --- Verify results is not nil
        if next(tmp_opts) ~= nil then
            opts = tmp_opts
        end
    end

    --- Data Validation: Check if options are populated
    if next(opts) == nil then
        --- Import in the default file type/extensions
        if file_extensions ~= nil then
            --- print("Extensions: " .. tostring(file_extensions))
            opts = file_extensions
        end
    end

    --- Define callback event function. Triggered after a menu item is selected from the popup menu window
    local cb = function(_, sel)
        print("Menu Works, Selected item: " .. sel)
    end

    --- Open popup menu for user to select a target file type/extension
    local bufnr = ShowMenu(opts, cb)

    print("Buffer Number: " .. bufnr)

    --- Return the value
end

function M.open()
    --- When UI is opened
end

function M.setup(opts)
    --- Activate on require().setup()
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

--- Return the master configuration option/values
return M

