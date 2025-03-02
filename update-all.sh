#!/bin/bash

# Store the root directory
ROOT_DIR=$(pwd)

# Update all repositories first
echo "🔄 Pulling latest changes..."

echo "📦 Updating backend..."
cd "${ROOT_DIR}/backend" || exit
git checkout main
git pull

echo "🎨 Updating frontend..."
cd "${ROOT_DIR}/frontend" || exit
git checkout main
git pull

echo "🔄 Updating main repository..."
cd "${ROOT_DIR}" || exit
git pull
git submodule update --remote

# Show status of all repositories
echo "\n📋 Current Status:"
echo "\n=== Backend Status ==="
cd "${ROOT_DIR}/backend" || exit
git status --short

echo "\n=== Frontend Status ==="
cd "${ROOT_DIR}/frontend" || exit
git status --short

echo "\n=== Main Repo Status ==="
cd "${ROOT_DIR}" || exit
git status --short

# Prompt for commit message
echo "\n💬 Enter commit message (leave empty to skip commits): "
read -r COMMIT_MSG

if [ -n "$COMMIT_MSG" ]; then
    # Backend changes
    echo "📦 Committing backend changes..."
    cd "${ROOT_DIR}/backend" || exit
    if [ -n "$(git status --porcelain)" ]; then
        git add --all  # This will stage deletions too
        git commit -m "Backend: ${COMMIT_MSG}"
        git push
        echo "✅ Backend updated"
    else
        echo "ℹ️ No changes in backend"
    fi

    # Frontend changes
    echo "🎨 Committing frontend changes..."
    cd "${ROOT_DIR}/frontend" || exit
    if [ -n "$(git status --porcelain)" ]; then
        git add --all  # This will stage deletions too
        git commit -m "Frontend: ${COMMIT_MSG}"
        git push
        echo "✅ Frontend updated"
    else
        echo "ℹ️ No changes in frontend"
    fi

    # Main repo changes
    echo "🔄 Updating main repository references..."
    cd "${ROOT_DIR}" || exit
    if [ -n "$(git status --porcelain)" ]; then
        git add --all  # This will stage deletions too
        git commit -m "Update submodule references: ${COMMIT_MSG}"
        git push
        echo "✅ Main repository updated"
    else
        echo "ℹ️ No changes in main repository"
    fi

    echo "✅ All repositories updated successfully!"
else
    echo "ℹ️ No commits made - repositories are up to date"
fi