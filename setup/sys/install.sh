#!/bin/bash



#! autor            => akileshas
#! created on       => 04-06-2025
#! last modified on => 04-06-2025
#! description      => system ( archlinux + i3wm + x11 ) setup script



# starting the installation script
echo "installing the required packages for my system..."

# checking if `paru` is installed
if ! command -v paru &> /dev/null; then
    echo
    echo "error: 'paru' is not installed !!!"
    exit 1
fi

echo && echo "installling the required packages for my system... done. ;)"
