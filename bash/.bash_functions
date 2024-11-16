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



#################################################
#                      END                      #
#################################################
