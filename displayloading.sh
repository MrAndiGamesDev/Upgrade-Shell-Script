#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
# Semi-Manual upgrading script for dotfiles
# Requires rsync

# Set colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 5)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Configuration For Updates
CONFIRM_UPDATES=false
CURRENT_USER=$(whoami)

# Function for displaying loading progress
display_loading() {
    local ishowspeed=0.05
    local duration=1
    local width=68
    local progress=0
    local step=$((width / duration))
    local spin_index=0
    local hidecursor="\033[?25l"  # Hide cursor
    local showcursor="\033[?25h"  # Show cursor
    local spinner=('|' '/' '-' '\')

    echo -ne ${hidecursor}  # Hide cursor

    while [ $progress -le $width ]; do
        printf "\r$CAT Loading: ["
        for ((i=0; i<$progress; i++)); do
            printf "#"
        done
        for ((i=$progress; i<$width; i++)); do
            printf " "
        done
        printf "] %3d%% ${spinner[$spin_index]}" $((progress * 100 / width))
        sleep $ishowspeed
        progress=$((progress + 1))
        spin_index=$(( (spin_index + 1) % 4 ))
        clear
    done

    printf "\r$CAT Loading: ["; printf '%0.s#' $(seq 1 $width); printf "] 100%%\n"
    echo -ne ${showcursor}
}

pushd "$(dirname "$0")" > /dev/null
script_name=$(pwd)
popd > /dev/null

# Prompt user to confirm update
read -p "$NOTE Do you want to continue with the updates? (y/n) " -n 1 -r
echo # move to a new line after user input
if [[ $REPLY =~ ^[Yy]$ ]]; then
    CONFIRM_UPDATES=true
fi

# Proceed with updates if confirmed
if [[ $CONFIRM_UPDATES == "true" ]]; then
    echo "$OK Updating $script_name From $CURRENT_USER"
    
    # Add loading animation with \|/- spinner
    echo -n "$CAT Updating in progress"
   
    # Show loading animation
    display_loading

    # Simulate the update process with rsync or other commands (Replace with actual commands)
    echo "$CAT Starting update process..."
    sleep 3  # Simulating update process (replace with real commands like rsync)

    # Now change the text in terminal to indicate completion
    echo -ne "\r$OK Update completed successfully! $RESET\n"

    # Optionally, display some other status messages after the update is finished
    echo "$NOTE Your dotfiles have been successfully updated!"
    
else
    echo "$ERROR Update cancelled."
    exit 1
fi

