#!/bin/bash
set -o errexit -o nounset

# Navigate to the app directory
cd DiceCloud/app

# Install npm dependencies
meteor npm install

# Start the Meteor application
exec meteor
