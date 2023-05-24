#!/bin/bash

# Define spinner function
spinner() {
    local message=$1
    local pid=$2
    local delay=0.25
    local spinstr='/-\|'
    printf "%s" "$message"
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Wrap the entire script in a subshell and pass its PID to the spinner function
(
# Perform any setup tasks here
grep -r "pattern" * &

# Install Git if necessary and clone the blockchain repository
if ! [ -x "$(command -v git)" ]; then
  # Install Git based on the user's OS
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get update
    sudo apt-get install git -y
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install git
  elif [[ "$OSTYPE" == "cygwin" ]]; then
    echo "Please install Git manually."
  else
    echo "Please install Git manually."
  fi
fi
git clone https://github.com/LifeDeFied/seedchain-test.git

# Install the required libraries based on the user's OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ./sync.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  ./sync.sh
elif [[ "$OSTYPE" == "cygwin" ]]; then
  echo "Please install the required libraries manually."
else
  echo "Please install the required libraries manually."
fi

# Execute any necessary commands or scripts to start the new blockchain

) & spinner "Automating tasks..." $$

# Wait for the subshell to finish
wait
