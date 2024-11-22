#!/bin/bash

# Function to detect project type
detect_project_type() {
  local repo_url=$1

  if [ -f "package.json" ]; then
    echo "Node.js project detected. Repository URL: $repo_url"
  elif [ -f "pom.xml" ]; then
    echo "Java Maven project detected. Repository URL: $repo_url"
  elif [ -f "build.gradle" ]; then
    echo "Java Gradle project detected. Repository URL: $repo_url"
  elif [ -f "requirements.txt" ]; then
    echo "Python project detected. Repository URL: $repo_url"
  elif [ -f "Gemfile" ]; then
    echo "Ruby project detected. Repository URL: $repo_url"
  elif [ -f "composer.json" ]; then
    echo "PHP project detected. Repository URL: $repo_url"
  elif [ -f "Cargo.toml" ]; then
    echo "Rust project detected. Repository URL: $repo_url"
  elif [ -f "Makefile" ]; then
    echo "Makefile project detected. Repository URL: $repo_url"
  elif [ -f "Dockerfile" ]; then
    echo "Docker project detected. Repository URL: $repo_url"
  else
    echo "Unknown project type. Repository URL: $repo_url"
  fi
}

# Call the function with the repository URL as an argument
detect_project_type "$1"