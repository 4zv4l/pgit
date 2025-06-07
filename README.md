# pgit

Basic git system in Perl

Following: https://thoughtbot.com/blog/rebuilding-git-in-ruby#git-commands

## Support

PGit currently implements the following commands:

```
- init   (init pgit repo)
- add    (add files for next commit)
- commit (create a commit and update HEAD to point to it)
- log    (-l or --list to list commit files)
- status (show current branch)
- branch (without arguments, list branches, otherwise switch/create branch)
```
