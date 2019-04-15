# custom-git-hooks
Follow the steps below to add custom git hooks to any repository. This repository contains the magical `hooks/autohook.sh` (a script which is almost entirely borrowed -- with few modifications -- from [this repository by nkantar](https://github.com/nkantar/Autohook)) as well as a few example custom scripts you could use.


## Background

Git hooks are useful for performing actions before or after making changes to the official state of a local or remote repository. Custom git hooks are essentially hooks that automatically run custom snippets of code based on which action you are trying to take. For example, if you would like to run your testing library just before pushing a commit to a remote repository, you could create a pre-push hook that will be triggered any time you attempt to push to that remote repository. If the testing fails, the push will also fail.

Note that this custom runnable script must be in your local version of the repository for the hook to work (at least, for this particular set-up I'm about to describe). You could place this directly in the appropriate subdirectory of the `.git` hidden directory in every git repository where git checks for custom hook scripts, however this will leave your custom hook script to be ignored in a git commit. Instead, this tutorial will show you how you can place these custom scripts inside the committable parts of your repository and then create symbolic links to the hidden portions where git looks for custom hook scripts. This will allow you to share the same hooks with all contributors to the repository, where they will only need to run 3 lines of code to set up your custom hooks (more on that below). Git hooks are ideal for generally smaller repositories with few developers, for example in simple R&D repos where CICD could be useful but the time cost of developing an entire CICD pipeline may not be ideal.


## Setup

Clone or init a repository. In this directory, create a subdirectory called hooks. which should have a subdirectory for each hook named for the hook you are trying to activate. See here for a description of all available hooks.

Additionally, please copy the `hooks/autohook.sh` script into the hooks subdirectory.

Finally, for each code routine you'd like to run, create shell scripts for each action. I like to separate these actions into discrete scripts since I tend to reuse parts of the routine across hooks. Your folder structure and example script should now look something like this for a repository named 'bayesianinferencetoolkit':

![Folder Setup](/images/foldersetup.png?raw=true "Folder Setup")

Here I have created an example script that will auto-generate documentation from docstrings (and another that will add the auto-generated documentation to the commit) every time I commit to the local repository. The final step is to (1) open terminal and make the `autohook.sh` script executable and (2) then run the autohook.sh bash script:

```
chmod +x hooks/autohook.sh
./hooks/autohook.sh install
```

We have now installed the symbolic links between the in-built (empty by default) git hooks and our custom hook scripts.
Now when committing, you should observe the output of `autohook.sh` on the terminal


You should be able to push this code into a remote repository, and in order for other users/developers to activate your git custom git hooks, they simply need to clone your repository and run the `autohook.sh` script with the `install` parameter as we did above. The symbolic links will be automatically created on their system.


## More Background

Git hooks are installed in every repository by default in the hidden folder `.git/hooks`. The problem with this is that `.git` is a hidden folder and changes in this folder and its subdirectories are ignored. I.e. if we place custom hooks scripts here and push our changes to a remote repository, the custom scripts will be ignored. In order to circumvent this problem, we place our scripts in a hooks folder in our main repository (so that it's not hidden) and create symbolic links to the appropriate subdirectories in `.git/hooks` so that when git tries to run the git hooks from the hidden folder, it is essentially redirected to our custom scripts.

The `autohook.sh` script is magical in that it finds all executable scripts that exist in the hooks subdirectories and automatically links them to the appropriate git hooks based on the name of script's parent folder.


## Acknowledgements

Please thank the real hero nkanter and their public repository https://github.com/nkantar/Autohook for the starter code upon which I only made small modifications.

