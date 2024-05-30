-- Plugin UI library/interface

--- Import dependency libraries/packages
local popup = require("plenary.popup") --- Popup window using plenary
local fileio = require("devenv.io.files") --- File I/O Processing

--- Initialize variables
local M = {}
local defaults = {}
local win_id --- Contains the popup window's ID
local win --- Contains the popup window object

--- Define the plugin's functions

--- comment
--- @param opts any
--- @param cb any
--- @return any
function M.create_menu(opts, cb)
    --- Initialize Variables
    local height = 20
    local width = 30
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    -- Get the current cursor position (row, col)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local current_line = cursor_pos[1]

    --- Create popup window and return the popup window's ID
    win_id, win = popup.create(opts, {
        title = "MyProjects", -- "DevEnvManage",
        highlight = "MyProjectWindow", -- "File Extensions/Types",
        line = math.floor(((vim.o.lines - height)/2) - 1), --- Number of rows/lines
        col = math.floor((vim.o.columns - width)/2), --- Number of columns
        minwidth = width,   --- Minimum Width of window
        minheight = height, --- Minimum height of window
        borderchars = borderchars, --- Border characters
        callback = cb, --- Callback Event Function
    })
end

--- Open Popup Menu Window, Set the temporary keymap for that specific buffer number and return the buffer number
--- comment
--- @return integer
function M.show_menu()
    --- Initialize Variables

    --- Open/Show popup menu for user to select items and Get buffer number from popup window
    local bufnr = vim.api.nvim_win_get_buf(win_id)

    --- Set keymapping only to the specific buffer number to close the menu
    vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua close_menu()<CR>", {silent=false})

    --- Return results
    return bufnr
end

--- Close popup menu after usage
function M.close_menu()
    vim.api.nvim_win_close(win_id, true)
end

--- Open Popup menu, select an item and return the selected menu item value
--- comment
--- @param callback any
function M.select_menu_item(callback)
    --- Initialize Variables

    --- Open the Popup menu window and return the buffer number
    local bufnr = vim.api.nvim_win_get_buf(win_id)

    --- Define a callback function to handle selection and call the specified callback with the selected item
    local function on_select()
        --- Obtain window and selection information
        local cursor = vim.api.nvim_win_get_cursor(win_id) --- Get the cursor object pointing to the window
        local selected_idx = cursor[1] --- Get the selected item's index
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) --- Get the number of lines within the popup menu buffer
        local selected_item = lines[selected_idx] --- Get the selected item corresponding to the index

        --- Trigger the callback event handler function passed and handle the selected item
        callback(selected_item)

        --- Close popup menu after usage
        M.close_menu()
    end

    --- Set keymapping for selection
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', '<cmd>lua require("devenv.ui").on_select()<CR>', { noremap = true, silent = true })

    --- Store the on_select function in the module so it can be called by the keymap
    M.on_select = on_select
end

--- Get File Types from a popup menu
--- comment
--- @param opts any
function M.get_file_type(opts)
    --- Initialize Variables
    local async_res = {} --- Initialize an asynchronous results table to contain the selected menu item
    local result = "" --- Initialize the result variable to return the file type
    local file_contents = {} --- Place all your default menu options here
    local config_filename = M.opts.config_filename --- Get the master table's configuration file name
    local file_extensions = M.opts.extensions --- Get the master table's file extensions list

    --- Data Validation: Check if file name is provided
    if config_filename ~= nil then
        print("Configuration Filename: " .. config_filename)

        --- Read menu contents from file
        file_contents = fileio.import_file_contents(config_filename)
        print("Contents imported: " .. tostring(file_contents))
    end

    --- Verify results is not nil
    if next(file_contents) == nil then
        --- Place all your default menu options here
        file_contents = file_extensions
    end

    --- This will make the stream synchronous
    local co = coroutine.running()

    --- Ensure that 'co' is a valid coroutine
    if not co then
        error("This function must be called within a coroutine")
    end

    --- Define callback event function. Triggered after a menu item is selected from the popup menu window
    local cb = function(_, sel)
        --- Return the result of the '.create()' function back up to the 'sel' callback object and
        --- store the sel local variable result into 'async_res.result'
        async_res.result = sel
        print("cb: " .. tostring(sel))

        --- Resume the coroutine after the menu has been created
        coroutine.resume(co)
    end

    --- Create popup menu with a file type/extension selection menu
    M.create_menu(file_contents, cb)

    --- Open popup menu for user to select a target file type/extension
    local bufnr = M.show_menu()
    print("Buffer Number: " .. bufnr)

    --- Open the popup menu, select an item from the menu list, return value backup to the caller via the callback event handler object
    M.select_menu_item(function(selected_item)
        --- Return the selected item back up to the 'selected_item' callback object and
        --- store the selected_item local variable into 'async_res.result'
        async_res.result = selected_item

        --- Resume the coroutine after user input is obtained
        coroutine.resume(co)
    end)

    --- Suspend execution until the callback event handler resumes it
    coroutine.yield()

    --- Obtain the result
    result = async_res.result

    --- Return the result
    return result
end

--- Set the script's setup function (Optional)
function M.setup(opts)
    M.opts = opts
    fileio.setup(opts)
end

--- Return the master configuration option/values
return M

