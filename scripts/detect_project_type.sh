#!/bin/bash

# Function to detect project type
detect_project_type() {
  local repo_url=$1

  if [ -f "package.json" ]; then
    if grep -q '"next"' package.json; then
      echo "Next.js project detected. Repository URL: $repo_url"
    elif grep -q '"react"' package.json; then
      echo "React project detected. Repository URL: $repo_url"
    else
      echo "Node.js project detected. Repository URL: $repo_url"
    fi
  elif [ -f "pom.xml" ]; then
    if grep -q '<artifactId>spring-boot-starter' pom.xml; then
      echo "Spring Boot project detected. Repository URL: $repo_url"
    else
      echo "Java Maven project detected. Repository URL: $repo_url"
    fi
  elif [ -f "build.gradle" ]; then
    if grep -q 'id "org.springframework.boot"' build.gradle; then
      echo "Spring Boot project detected. Repository URL: $repo_url"
    else
      echo "Java Gradle project detected. Repository URL: $repo_url"
    fi
  elif [ -f "requirements.txt" ]; then
    if grep -q 'flask' requirements.txt; then
      echo "Flask project detected. Repository URL: $repo_url"
    elif grep -q 'django' requirements.txt; then
      echo "Django project detected. Repository URL: $repo_url"
    else
      echo "Python project detected. Repository URL: $repo_url"
    fi
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