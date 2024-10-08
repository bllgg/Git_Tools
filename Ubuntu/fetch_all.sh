#!/bin/bash

# Define the directory to search for repositories (default to current directory if not provided)
REPO_DIR=${1:-$(pwd)}

echo "Looking for Git repositories in directory: $REPO_DIR"

# Find all directories containing a .git folder (i.e., Git repositories)
for repo in $(find "$REPO_DIR" -name ".git" -type d | sed 's|/\.git||'); do
    echo "Fetching repository in: $repo"
    # Change to the repo directory
    cd "$repo"
    
    # Fetch all branches from the remote
    git fetch --all
    
    echo "Finished fetching repository: $repo"
    echo "--------------------------------------------"
    
    # Return to the base directory
    cd "$REPO_DIR"
done

echo "Finished fetching all repositories."
