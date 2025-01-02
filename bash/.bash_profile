#!/bin/bash

#################################################
#                BASH PROFILE                   #
#################################################



# Source the bashrc file
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Qt Global Variables
export QT_STYLE_OVERRIDE=adwaita-dark
export QT_QPA_PLATFORMTHEME=qt6ct

# Sourcing the `broot` shell script
if [ -f /home/asa/.config/broot/launcher/bash/br ]; then
    source /home/asa/.config/broot/launcher/bash/br
fi



#################################################
#                      END                      #
#################################################
