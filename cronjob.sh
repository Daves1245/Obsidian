#!/bin/bash

PROJECT_PATH=$HOME/Obsidian
LOG_PATH=$HOME/Obsidian/logs/vault.log

cd $PROJECT_PATH || exit

echo "Script run at: $(date)" >> "$LOGFILE"

# only push on changes found, but always log when script runs
if [[ -n $(git status --porcelain) ]]; then
    git add .
    COMMIT_MESSAGE="Auto-commit: $(date)"
    git commit -m "$COMMIT_MESSAGE"
    echo ": $COMMIT_MESSAGE" >> "$LOGFILE"
    git diff HEAD~1 HEAD >> "$LOGFILE"
    git push origin main
else
    echo "No changes found" >> "$LOGFILE"
fi
