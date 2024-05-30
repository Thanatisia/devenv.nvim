# CHANGELOGS

## Table of Contents
+ [2024-05-27](#2024-05-27)
+ [2024-05-28](#2024-05-28)
+ [2024-05-30](#2024-05-30)

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

