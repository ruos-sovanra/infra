#!/bin/bash

# Get the dynamic variables
APP_NAME=$1
APP_VERSION=$2

# Log the deployment information
echo "Deploying ${APP_NAME} version ${APP_VERSION}" > /root/istad/deployment.log
echo "Deployment started at $(date)" >> /root/istad/deployment.log

# Simulate the deployment task (could be kubectl, helm, etc.)
echo "Deployment for ${APP_NAME} version ${APP_VERSION} completed" >> /root/istad/deployment.log
