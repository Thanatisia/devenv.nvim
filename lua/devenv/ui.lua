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

function M.close_menu()
    --- Close popup menu after usage
    vim.api.nvim_win_close(win_id, true)
end

--- Handle selection
--- @param bufnr integer
function M.handle_selection(bufnr)
    local cursor_pos = vim.api.nvim_win_get_cursor(win_id)
    local selected_line = cursor_pos[1]
    local selected_item = vim.api.nvim_buf_get_lines(bufnr, selected_line - 1, selected_line, false)[1]

    -- Call the callback with the selected item
    M.selection_callback(selected_item)

    -- Close the menu
    M.close_menu()
end

--- Get File Types from a popup menu
--- comment
--- @param opts any
--- @return string
function M.get_file_type(opts)
    --- Initialize Variables
    local res = "" --- This will contain the selected menu item
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
        local co_status = coroutine.status(co)
        if co_status == "suspended" then
            --- Resume the coroutine after user input is obtained and return the coroutine's yield
            coroutine.resume(co, sel)
        end
    end

    --- Create popup menu with a file type/extension selection menu
    M.create_menu(file_contents, cb)

    --- Open popup menu for user to select a target file type/extension
    local bufnr = M.show_menu()
    print("Buffer Number: " .. bufnr)

    --- Suspend execution until the callback resumes it
    local result = coroutine.yield()
    print("Callback Result: " .. result)

    --- Return the value
    return result
end

--- Set the script's setup function (Optional)
function M.setup(opts)
    M.opts = opts
    fileio.setup(opts)
end

--- Return the master configuration option/values
return M

