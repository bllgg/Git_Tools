#!/bin/bash

# Define the directory to search for repositories (default to current directory if not provided)
REPO_DIR=${1:-$(pwd)}

echo "Looking for Git repositories in directory: $REPO_DIR"

# Find all directories containing a .git folder (i.e., Git repositories)
for repo in $(find "$REPO_DIR" -name ".git" -type d | sed 's|/\.git||'); do
    echo "Pushing repository in: $repo"
    # Change to the repo directory
    cd "$repo"
    
    # Fetch and push each local branch to the remote
    branches=$(git branch --format="%(refname:short)")
    for branch in $branches; do
        echo "Pushing branch: $branch to origin"
        git push origin $branch
    done
    
    echo "Finished pushing repository: $repo"
    echo "--------------------------------------------"
    
    # Return to the base directory
    cd "$REPO_DIR"
done

echo "Finished pushing all repositories."
