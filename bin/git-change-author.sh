#!/bin/sh
# https://help.github.com/en/articles/changing-author-info

authorname="$1":
fromemail="$2";
toemail="$3";

git filter-branch --env-filter '

OLD_EMAIL="'"$fromemail"'"
CORRECT_NAME="'"$authorname"'"
CORRECT_EMAIL="'"$toemail"'"

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
