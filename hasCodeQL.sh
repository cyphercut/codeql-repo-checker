#!/bin/bash

# set the owner and token
OWNER="GITHUB_OWNER"
TOKEN=${TOKEN:-$GITHUB_TOKEN}

# Define the excluded languages array
excluded_languages=("Scala" "Lua")

function check_pr_for_codeql() {
    repo=$1
    open_prs=$(gh api repos/$OWNER/$repo/pulls?state=open | jq -r '.[].number')
    if [ -z "$open_prs" ]; then
        echo $repo
    else
        for pr in $open_prs; do
            codeql_file=$(gh api repos/$OWNER/$repo/pulls/$pr/files | jq -r '.[].filename' | grep '.github/workflows/codeql.yml')
            if [ -z "$codeql_file" ]; then
                echo $repo
                break
            fi
        done
    fi
}

# Get the list of repositories in json format
repos=$(gh repo list $OWNER -L 999 --no-archived --json name)

# Iterate through each repository
for repo in $(echo "${repos}" | jq -r '.[].name'); do

    # Check the language of the repository
    language=$(gh api repos/$OWNER/$repo | jq -r '.language')

    # Check if the language is in the excluded languages array
    if [[ " ${excluded_languages[*]} " == *" $language "* ]]; then
        continue
    fi
    
    # Check for codeql.yml file
    default_branch=$(gh api repos/$OWNER/$repo | jq -r '.default_branch')
    codeql=$(gh api repos/$OWNER/$repo/tree/$default_branch/.github/workflows 2> /dev/null | jq -r '.name')
    if [ "$codeql" != "codeql.yml" ]; then
        check_pr_for_codeql $repo
    fi
done

