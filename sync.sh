#!/bin/bash

# Install Git
sudo apt-get update
sudo apt-get install -y git

# Install nvm for managing Node.js versions
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.nvm/nvm.sh

# Install Node.js 16.11
nvm install 16.11.0

# Check that Node.js has been installed correctly
if [ "$(node -v)" != "v16.11.0" ]; then
    echo "Error: Node.js installation failed"
else
    echo "Node.js has been installed successfully"
fi

# Use nvm to switch to Node.js 16.11.0
nvm use 16.11.0

# Check that Node.js version has been switched correctly using nvm
if [ "$(node -v)" != "v16.11.0" ]; then
    echo "Error: Failed to switch to Node.js version 16.11.0"
else
    echo "Node.js version 16.11.0 has been activated"
fi

# Check that Git has been installed correctly
if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    echo "Error: Git installation failed"
else
    echo "Git has been installed successfully"
fi

# Remove existing installation of Go and install version 1.20.3
sudo rm -rf /usr/local/go
sudo curl -O https://dl.google.com/go/go1.20.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version

# Remove existing installation of Ignite and install latest version
sudo rm -rf /usr/local/ignite
sudo curl https://get.ignite.com/cli! | bash
sudo mv ignite /usr/local/bin
ignite version