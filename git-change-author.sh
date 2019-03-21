#!/bin/sh
# https://help.github.com/en/articles/changing-author-info

git filter-branch --env-filter '

OLD_EMAIL="mickael@example.com"
CORRECT_NAME="Mickaël Wolff"
CORRECT_EMAIL="m@lupusmic.org"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
