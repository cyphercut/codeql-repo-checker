# CodeQL Repo Checker
Are you tired of manually checking hundreds of code repositories to ensure that CodeQL is enabled? Look no further! This script automates the process of checking for CodeQL in repositories, either on the default branch or in an open pull request.

### Getting Started
To use this script, you will need to set the OWNER variable to the GitHub username of your organization and the TOKEN variable to your GitHub token. You can also define an array of excluded languages, which will be ignored in the check. By default, the script is set to exclude Scala and Lua.

### How it works
The script uses the GitHub API to get a list of all repositories belonging to the organization and filters them to only include repositories that are not archived. It then iterates through each repository and uses the GitHub API to get the language of the repository. If the language of the repository is in the excluded languages array, the script skips to the next repository.

If the repository is not in the excluded languages array, the script uses the GitHub API

#### Getting the owner and token
- First, you will need to create a personal access token on GitHub by going to your settings and selecting "Developer Settings" and then "Personal Access Tokens".

- Click on "Generate Token" and give it a name, select the scope of the token.

- Once you have your token, set the OWNER variable to your GitHub organization name and the TOKEN variable to your personal access token.
You can do this by adding the following line at the beginning of the script: OWNER="YOUR_ORGANIZATION_NAME" and TOKEN="YOUR_PERSONAL_ACCESS_TOKEN"

- If you're planning to run this script on a CI/CD pipeline, you can set the TOKEN variable to the environment variable $GITHUB_TOKEN which is automatically set by GitHub actions.

- Once you have set the OWNER and TOKEN variables, you are ready to run the script and check your repositories for CodeQL.

Note
Please be sure to keep your token safe, do not share it with anyone, and avoid committing it to your repository.
