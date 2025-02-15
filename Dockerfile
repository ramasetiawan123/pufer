# Use an official Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    gnupg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add PufferPanel repository and install PufferPanel
RUN curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash && \
    sudo apt-get update && \
    sudo apt-get install -y pufferpanel

# Create a new user for PufferPanel and enable the service
RUN sudo pufferpanel user add --admin --username admin --password adminpassword && \
    sudo systemctl enable --now pufferpanel

# Expose the port PufferPanel uses
EXPOSE 8080

# Start PufferPanel
CMD ["pufferpanel"]

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
