: "
Please place your program documentations and description comments here
"

main() {
    argv=("$@")
    argc="${#argv[@]}"

    # Check if there are arguments provided
    if [[ $argc > 0 ]] then
        # While there are still arguments
        # Get the next argument
        while [[ "$1" != "" ]]; do
            # Switch-case the current argument
            case "$1" in
                "-h" | "--help")
                    # Display Help
                    printf "%s" "Display Help"
                    ;;
                "-v" | "--version")
                    # Display system version
                    printf "%s" "Display system version information"
                    ;;
                *)
                    # Invalid argument
                    printf "%s" "Invalid argument: $1"
                    ;;
            esac

            # Shift 1 position to the left so that the element is kicked out and goes to the next element
            shift 1
        done
    else
        printf "%s" "No arguments provided"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
