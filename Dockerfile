FROM ubuntu:latest

# Update package list and install required packages
RUN apt-get update -y --quiet \
    && apt-get install -y --no-install-recommends --quiet \
    bsdtar \
    curl \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a symbolic link for bsdtar as tar
RUN ln -sf $(which bsdtar) /usr/bin/tar

# Create a new user and set up the home directory
RUN useradd --create-home --shell /bin/bash dicecloud

# Switch to the new user and set the working directory
USER dicecloud
WORKDIR /home/dicecloud

# Install Meteor
RUN curl https://install.meteor.com/?release=1.8.0.2 | sh

# Set the PATH environment variable to include Meteor
ENV PATH="${PATH}:/home/dicecloud/.meteor"

# Copy the dev.sh script and ensure it has the appropriate permissions
COPY dev.sh ./dev.sh
RUN chmod +x ./dev.sh

# Expose the required TCP port
EXPOSE 8080

# Set the entry point to the dev.sh script
ENTRYPOINT ["./dev.sh"]
