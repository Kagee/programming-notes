# Get script dir
````bash
#! /usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
````
https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script

# Yes / No prompt
````bash
ask() {
    local prompt default reply
    if [[ ${2:-} = 'Y' ]]; then
        prompt='Y/n'; default='Y';
    elif [[ ${2:-} = 'N' ]]; then
        prompt='y/N'; default='N';
    else
        prompt='y/n'; default='';
    fi

    while true; do
        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty

        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}
````
https://gist.github.com/karancode/f43bc93f9e47f53e71fa29eed638243c
