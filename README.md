# devenv.nvim

## Information
### Description
- devenv.nvim is a Development workspace manager plugin, containing various functionalities that assists in the improvements of QoL in anyone's development environment
    - such as
        - Selecting the file type you wish to create from a buffer popup window,
            + creating a new file with the extension of the selected file type, and
            + populating the newly-created file with snippets corresponding to the file type

### Plugin/Package
+ Version: v0.2.0

## Setup
### Dependencies
+ nvim

### Pre-Requisites

### Installing
- Using a plugin manager
    - lazy.nvim
        ```lua
        {
            "Thanatisia/devenv.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            opts = {},
            config = function()
                require("devenv").setup({
                    config_filename = "config.txt", --- Specify the file name of the custom configuration file (containing the list of extensions) you wish to import here
                    snippets_dir = "snippets", --- Custom Snippets directory
                    extensions = {
                        --- Place your file extensions here
                        "c", --- C
                        "cpp", --- C++
                        "py", --- Python
                        "js", --- Javascript
                    },
                })
            end
        }
        ```

## Documentations

## Customizations
### Configuration Key-Value Settings
- `config_filename` : Specify the file name of the custom configuration file (containing the list of extensions) you wish to import here
    + Type: String
    + Default Value: "config.txt"
- `snippets_dir` : Specify a custom snippets directory to find all your snippet template files. The snippets in this directory will be used as templates (i.e. DevEnvCopy => Copy a snippet of your choice to a new file)
    + Type: String
    + Default Value: "snippets"
    - Directory Structure
        ```
        root/ : Path to your working directory
            snippets/ : Snippets directory
                snippet-file.extension
                ...
        ```
- `extensions` : Place your supported list of file extensions here
    + Type: Array
    - Default Values:
        ```lua
        {
            "c", --- C
            "cpp", --- C++
            "py", --- Python
            "js", --- Javascript
        }
        ```

### Configuration File Contents

> Place all your supported file extension/types in this file, with each on a new line

```
"c"
"cpp"
"py"
"js"
...
```

## Wiki

## Resources

## References
+ [GitHub - nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

## Remarks

