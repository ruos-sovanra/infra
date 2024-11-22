#!/bin/bash

# Function to detect project type
detect_project_type() {
  local repo_url=$1
  local project_path="temp-project-dir"

  # Clone the Git repository to the temporary directory
  echo "Cloning Git repository from ${repo_url} into ${project_path}..."
  git clone -b main ${repo_url} ${project_path}

  # Detect the project type from the cloned repository
  cd ${project_path}
  local project_type=$(detect_project_type_from_dir)

  if [ -n "${project_type}" ]; then
    echo "Detected project type: ${project_type}"

    # Check if the Dockerfile exists
    if [ -f "Dockerfile" ]; then
      echo "Dockerfile already exists at ${project_path}/Dockerfile, skipping generation."
    else
      echo "No Dockerfile found at ${project_path}/Dockerfile."
    fi

    # Clean up the cloned project directory
    cd ..
    rm -rf ${project_path}

    echo ${project_type}
  else
    # Clean up the cloned project directory in case of error
    cd ..
    rm -rf ${project_path}

    echo "Unable to detect the project type for the repository at ${repo_url}."
    exit 1
  fi
}

# Function to detect project type from directory
detect_project_type_from_dir() {
  if [ -f "package.json" ]; then
    if grep -q '"next"' package.json; then
      echo "nextjs"
    elif grep -q '"react"' package.json; then
      echo "react"
    else
      echo "nodejs"
    fi
  elif [ -f "pom.xml" ]; then
    echo "springboot-maven"
  elif [ -f "build.gradle" ]; then
    echo "springboot-gradle"
  elif [ -f "pubspec.yaml" ]; then
    echo "flutter"
  else
    echo ""
  fi
}

# Call the function with the repository URL as an argument
detect_project_type "$1"