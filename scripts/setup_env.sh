#!/usr/bin/env bash

# This script is run to setup the environment for the project.
# It installs the required packages and sets up the environment variables.

# Install the required packages

# Check if Docker installed

if ! [ -x "$(command -v docker)" ]; then
    # Install Docker
    echo "Docker is not installed. Installing Docker..."
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Add the current user to the docker group if $ENV is dev or test
    if [ "$ENV" = "dev" ] || [ "$ENV" = "test" ]; then
        sudo groupadd docker
        sudo usermod -aG docker $USER
    fi

    echo "Docker installed successfully."
    echo "Log out and log back in so that your group membership is re-evaluated or run 'newgrp docker' to activate the changes."
fi
