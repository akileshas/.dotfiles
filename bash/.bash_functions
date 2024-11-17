#!/bin/bash

#################################################
#                BASH FUNCTIONS                 #
#################################################



# Clean the Compiled Python Files
cls_pyc() {
    # Remove all .pyc files recursively
    find . -name '*.pyc' -delete
}

# Creates a directory (if it doesn't exist) and changes into it
mcd() {
    # If a directory name is provided, create the directory and move into it
    [[ "$1" ]] && mkdir -p "$1" && cd "$1";  
}

# Reset the git repository
nah() {
    git reset --hard

    if [[ $1 == "-f" ]]; then
        git clean -df
    fi
}

# Open the default program for the file
open () {
    xdg-open $* > /dev/null 2>&1
}



#################################################
#                      END                      #
#################################################
