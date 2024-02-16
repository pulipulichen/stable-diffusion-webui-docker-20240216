# Add changes to the staging area
git add .

# Commit changes with the current time
commit_time=$(date +"%Y-%m-%d %H:%M:%S")
git commit -m "Changes made at $commit_time"

# Push changes to the remote repository
git push
