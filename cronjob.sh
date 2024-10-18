#!/bin/bash

PROJECT_PATH=$HOME/Obsidian
LOG_PATH=$HOME/Obsidian/logs/vault.log

cd "$PROJECT_PATH" || exit

# Adding a well-formatted log entry for the script run
{
    echo ""
    echo "=================================================="
    echo "Script run at: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "=================================================="
} >> "$LOG_PATH"

# Only push on changes found, but always log when the script runs
if [[ -n $(git status --porcelain) ]]; then
    git add .
    COMMIT_MESSAGE="Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
    git commit -m "$COMMIT_MESSAGE"
    
    # Logging the commit message and changes in a structured format
    {
        echo "Changes found and committed."
        echo "Commit message: $COMMIT_MESSAGE"
        echo "Files changed:"
        git diff --name-only HEAD~1 HEAD
        echo "Diff:"
        git diff HEAD~1 HEAD
        echo "Pushing changes to remote..."
    } >> "$LOG_PATH"

    git push origin main
    echo "Push completed at: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_PATH"
else
    # Log entry for no changes found
    echo "No changes found at: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_PATH"
fi

