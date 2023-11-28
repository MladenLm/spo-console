#!/bin/bash

# Function to print welcome message
print_big_green_centered() {
    local text="$1"
    local text_length=${#text}
    local delay=0.1  # Adjust this value to control the typing speed

    # Get terminal width and height
    local term_width=$(tput cols)
    local term_height=$(tput lines)

    # Calculate center position
    local center_x=$(( (term_width - text_length) / 2 ))
    local center_y=$(( term_height / 2 ))

    # Set text color to green
    tput setaf 2

    # Print each character with a typing effect
    for ((i = 0; i < text_length; i++)); do
        tput cup $center_y $((center_x + i))
        echo -n "${text:i:1}"
        sleep $delay
    done

    # Reset text attributes
    tput sgr0
}

# Function to prompt user for environment and save the answer
function prompt_environment() {
    read -p "Will this be used on your hot environment (1) or cold environment (2)? " environment_choice
    echo "$environment_choice" > environment_choice.txt
}

# Function to load saved environment choice
function load_environment_choice() {
    if [ -e environment_choice.txt ]; then
        environment_choice=$(cat environment_choice.txt)
    else
        environment_choice=0
    fi
}

# Function to handle hot environment options
function hot_environment_options() {
    echo "Hot environment options:"
    echo "1. Register a stake pool"
    echo "2. Update stake pool information"
    echo "3. Issue new operational certificate"
}

# Function to handle cold environment options
function cold_environment_options() {
    echo "Cold environment options:"
    echo "1. KES Key rotation"
    echo "2. Sign Transaction"
    echo "3. Issue new certificate"
}

# Main script

# Load environment choice
load_environment_choice

# Check if it's the first time running or if environment_choice is not set
if [ "$environment_choice" -eq 0 ]; then
    print_big_green_centered "Hello Commander"
    echo " "
    prompt_environment
else
    print_big_green_centered "Welcome back, Commander"
    echo " "
    echo "Using saved environment choice: $environment_choice"
fi

# Main menu
while true; do
    if [ "$environment_choice" -eq 1 ]; then
        hot_environment_options
    elif [ "$environment_choice" -eq 2 ]; then
        cold_environment_options
    fi

    echo "4. Quit"

    read -p "Choose an option (1-4): " choice

    case "$choice" in
        1|2|3)
            echo "You chose option $choice"
            # Add your logic for each option here
            ;;
        4)
            echo "Quitting the script. Goodbye, commander!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please choose a valid option."
            ;;
    esac
done
