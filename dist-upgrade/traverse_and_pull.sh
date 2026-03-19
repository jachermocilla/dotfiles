#!/bin/bash

# traverse_and_pull.sh
# Recursively traverses directories and performs git pull on all found repos

TARGET_DIR="${1:-.}"
MAX_DEPTH="${2:-5}"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Directory '$TARGET_DIR' does not exist."
  exit 1
fi

echo "Scanning for git repositories in: $(realpath "$TARGET_DIR") (max depth: $MAX_DEPTH)"
echo "----------------------------------------"

success=0
failed=0
skipped=0

while IFS= read -r git_dir; do
  repo_dir=$(dirname "$git_dir")
  repo_name=$(basename "$repo_dir")

  if [ -d "$repo_dir/.git" ]; then
    echo "[ REPO ] $repo_name"
    output=$(git -C "$repo_dir" pull 2>&1)
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
      echo "   [ OK ] $(echo "$output" | tail -1)"
      ((success++))
    else
      echo "   [ FAIL ] $(echo "$output" | tail -1)"
      ((failed++))
    fi
  else
    echo "[ SKIP ] $repo_name"
    ((skipped++))
  fi

done < <(find "$TARGET_DIR" -mindepth 1 -maxdepth "$MAX_DEPTH" -name ".git" -type d | sort)

echo "----------------------------------------"
echo "Success: $success  Failed: $failed  Skipped: $skipped"
