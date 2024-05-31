-- General Utilities Module

--- Import dependency libraries/packages

--- Initialize the lua master dictionary mapping
local M = {}

--- Set the master table's default options
M.opts = {}

function M.open()
    --- When UI is opened
end

function M.setup(opts)
    --- Activate on require().setup()
    M.opts = opts
end

--- Utilities

---The file system path separator for the current platform.
M.path_separator = "/"
M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1
if M.is_windows == true then
  M.path_separator = "\\"
end

---Split string into a table of strings using a separator.
---@param inputString string The string to split.
---@param sep string The separator to use.
---@return table table A table of strings.
M.split = function(inputString, sep)
  local fields = {}

  local pattern = string.format("([^%s]+)", sep)
  local _ = string.gsub(inputString, pattern, function(c)
    fields[#fields + 1] = c
  end)

  return fields
end

---Joins arbitrary number of paths together.
---@param ... string The paths to join.
---@return string
M.path_join = function(...)
  local args = {...}
  if #args == 0 then
    return ""
  end

  local all_parts = {}
  if type(args[1]) =="string" and args[1]:sub(1, 1) == M.path_separator then
    all_parts[1] = ""
  end

  for _, arg in ipairs(args) do
    arg_parts = M.split(arg, M.path_separator)
    vim.list_extend(all_parts, arg_parts)
  end
  return table.concat(all_parts, M.path_separator)
end

---Print a table separated by a specific delimiter
---comment
---@param t any
---@param sep any
function M.print_table(t, sep)
    --- Data Validation: Separator/Delimiter Null Value Check
    if sep == nil then
        --- Set as default value
        sep = " : "
    end

    --- Iterate the table Key-Value pair mapping (aka dictionary) into key and value objects
    for k,v in pairs(t) do
        --- Print the key and value separated by the seperator/delimiter
        print(k .. tostring(sep)  .. v)
    end
end

--- Split the specified string by the given pattern
--- comment
--- @param target_str any
--- @param sep any
--- @param pattern any
--- @return table
function M.splitstr(target_str, sep, pattern)
    --- Initialize Variables
    local res_table = {}

    --- Data Validation: String Null Value check
    if target_str ~= nil then
        --- Data Validation: Separator/Delimiter Null Value check
        if sep == nil then
            sep = "%s"
        end

        --- Data Validation: Pattern Null Value check
        if pattern == nil then
            pattern = "([^" .. sep .. "]+)"
        end

        --- Match the target string with the specified patterns and Obtain all matched substrings
        local matched = string.gmatch(target_str, pattern)

        --- Iterate through the matched results and insert into the table
        for str in matched do
            table.insert(res_table, str)
        end
    end

    --- Return value
    return res_table
end

--- Split file name into file name and file extension
--- comment
--- @param full_filename any
--- @return unknown
--- @return unknown
function M.split_fname(full_filename)
    --- Initialize Variables
    local file_name = ""
    local file_extension = ""

    --- Split the filename into its components
    local file_name_spl = M.splitstr(full_filename, ".")

    --- Obtain the 2 elements
    file_name = file_name_spl[1]
    file_extension = file_name_spl[2]

    --- Return
    return file_name, file_extension
end

--- Obtain the N-th element of a given list, where n = The index/element starting from 1
--- comment
--- @param target_table any
--- @param n any
--- @return unknown
function M.get_nth_element(target_table, n)
    --- Initialize Variables
    local res_table = {}

    --- Obtain the n-th entry of the table from the end, counting from 1 (i.e. the last item has n=1)
    local nth_element = target_table[#target_table+1+n]

    return nth_element
end

--- Obtain the last-Nth element of a given list, where n = The last Nth index/element starting from 1
--- comment
--- @param target_table any
--- @param n any
--- @return unknown
function M.get_last_nth_element(target_table, n)
    --- Initialize Variables
    local res_table = {}

    --- Obtain the n-th entry of the table from the end, counting from 1 (i.e. the last item has n=1)
    local last_element = target_table[#target_table+1-n]

    return last_element
end

--- Return the master configuration option/values
return M

