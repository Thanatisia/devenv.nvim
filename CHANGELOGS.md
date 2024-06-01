# CHANGELOGS

## Table of Contents
+ [2024-05-27](#2024-05-27)
+ [2024-05-28](#2024-05-28)
+ [2024-05-30](#2024-05-30)
+ [2024-05-31](#2024-05-31)
+ [2024-06-01](#2024-06-01)

## Logs
### 2024-05-27
#### 2344H
+ Initial Commit

+ Version: v0.1.0

- New
    - Added new documents
        + CHANGELOGS.md
        + CONTRIBUTING.md
        + README.md
    - Added new directory 'plugin' for testing and development
        + Added new document 'config.txt'
        + Added new document 'test.lua'
    - Added new directory 'lua' for the start of the source codes
        - Added new directory 'devenv' for the plugin's core libraries and functionalities
            + Added new source code 'config.lua' : This is the plugin's config file containing the settings from init.lua
            + Added new source code 'init.lua' : The main entry point of the plugin
            + Added new source code 'ui.lua' : Contains a WIP UI library using plenary to create the popup menu window for user input. For separation-of-duty

### 2024-05-28
#### 1329H
- Updates
    - Updated module 'init.lua' in 'lua/devenv'
        + Test: Exporting to external libraries

#### 1342H
- Updates
    - Updated module 'init.lua' in 'lua/devenv'
        + Test: Creating new user command for obtaining a file type from a popup menu, creating the file and populating the file with a snippet corresponding to the file type
    - Updated module 'ui.lua' in 'lua/devenv'
        + Test: Returning of the selected module item

#### 1409H
- Updates
    - Updated module 'init.lua' in 'lua/devenv'
        + Test: Added opts option pass to function 'get_file_type()'
        + Test: Adding of statements after getting file type
    - Updated module 'ui.lua' in 'lua/devenv'
        + Test: Modifying function 'get_file_type()' to take in opts table from the init.lua entry point master table
        + Test: Fixing opts nil value

#### 2317H
- New
    - Added new directory 'api' in 'lua/devenv' for containing Neovim Lua API-related lua scripts/modules
        + Added new module 'usercmds.lua' in 'lua/devenv/api' for containing Neovim User Command definitions
- Updates
    - Updated module 'init.lua' in 'lua/devenv'
        + Test: Testing refactoring of user commands into 'lua/devenv/api/usercmds.lua'
    - Updated module 'ui.lua' in 'lua/devenv'
        + Test: Testing refactoring of variable name 'opts' in 'get_file_type()' to 'file_contents'

### 2024-05-30
#### 0931H
- New
    - Added new directory 'io' in 'lua/devenv' for containing I/O Processing-related lua scripts/modules
        + Added new module 'files.lua' for File I/O Handling
- Updates
    + Setting Baseline

#### 1811H
- Updates
    - Updated module 'usercmds.lua' in 'lua/devenv/api'
        + Did a refactor and removed all coroutine functionalities and replaced with using callback event handlers as an 'elevator' to bring the results back up
    - Updated module 'ui.lua' in 'lua/devenv'
        + Did a refactor and removed all coroutine functionalities and replaced with using callback event handlers as an 'elevator' to bring the results back up

#### 1827H
- Updates
    - Updated 'CHANGELOGS.md'
        + Replaced 'init.lua' => 'usercmds.lua' in '2024-05-30 1811H'
    - Updated module 'usercmds.lua' in 'lua/devenv/api'
        + Added in coroutine functionalities for asynchronous handling synchronously
    - Updated module 'ui.lua' in 'lua/devenv'
        + Added in coroutine functionalities for asynchronous handling synchronously
        + Added in comments to the coroutine functions

### 2024-05-31
#### 0942H
- New
    + Added new module 'directory.lua' in 'lua/devenv/io/'
    + Added new module 'utils.lua' in 'lua/devenv/'
    - Added new directory 'snippets/' for holding file snippets containing templates for various file types
        + Added new snippet 'index.css'
        + Added new snippet 'index.html'
        + Added new snippet 'init.lua'
        + Added new snippet 'main.c'
        + Added new snippet 'main.py'
        + Added new snippet 'main.sh'

- Updates
    - Updated module 'usercmds.lua' in 'lua/devenv/api/'
        + Updated comments
        + Added directory and file creation after the asynchronous popup menu item selection
    - Updated module 'config.lua' in 'lua/devenv/'
        + Added new configuration option 'snippets_dir' for adding a custom snippets directory
    - Updated module 'files.lua' in 'lua/devenv/io/'
        + Added comments
        + Added new functions 'check_file_exists()' and 'create_new_file()'
    - Updated module 'ui.lua' in 'lua/devenv/'
        + Performed some cleanup
    - Updated test source 'test.lua' in 'plugin/'
        + Added new configuration option 'snippets_dir'

#### 1002H
- Updates
    - Updated module 'directory.lua' in 'lua/devenv/io/'
        - Replaced 'os.execute()' with 'io.popen()' (sub)process pipe execution 
            + for extra security in the form of prepared process calls instead of direct execution
            + As well as to retrieve the standard streams (output/error)

### 2024-06-01
#### 0000H
- New
    + Added new document 'TODO.md' for TODO list and pipelines

- Updates
    - Updated document 'README.md'
        + Added new configuration key-value 'snippets_dir' into the configuration example
    - Updated module 'usercmds.lua' in 'lua/devenv/api/'
        + Added new user command 'DevEnvCopy' for copying a snippet file from the 'snippets' directory to a new file
    - Updated module 'directory.lua' in 'lua/devenv/io/'
        + Added new function 'scandir()' which will scan the directory and list all contents/files of the directory
    - Updated module 'ui.lua' in 'lua/devenv/'
        + Fixed close_menu() keybind issue
        + Added asynchronous function 'get_target_snippet()' to open a popup menu (using plenary.popup()) and select a snippet file from the snippets directory
    - Updated module 'utils.lua' in 'lua/devenv/'
        + Added function 'print_table()'
        + Added function 'splitstr()'
        + Added function 'split_fname()'
        + Added function 'get_nth_element()'
        + Added function 'get_last_nth_element()'

#### 1114H
- Updates
    - Updated document 'TODO.md'
        + Added new TODO for function 'copy()' in 'devenv/io/files.lua'
    - Updated module 'usercmds.lua' in 'lua/devenv/api/'
        - User Command 'DevEnvCopy'
            + Added logic for file copy - copying the selected snippet file from the snippets directory and writing to a new file
    - Updated module 'files.lua' in 'lua/devenv/io/'
        - Updated function 'import_file_contents()'
            + Added file pointer/handle/descriptor close after use
            + Plans to rename this function into 'read_file()'
        - Updated function 'create_new_file()' 
            + Added support for writing string contents and table contents into a file
            + Plans to rename this function into 'overwrite()'
        + Added new function 'append_file()' to append string contents and table contents into an exiting file without overwriting/trunking
        - Added new function 'copy()' to copy the contents of one file (source) into another file (destination)
            - Note
                + This function will overwrite existing files
                + TODO: Add flag to 'overwrite'
        + Added new function 'merge()' to merge/append the contents of one file (source) into another file (destination)

