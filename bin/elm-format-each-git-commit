#!/bin/bash

ELMFORMAT="npx elm-format"

die()
{
    echo "Dying: $1"
    exit 1
}

main()
{
    local leaf=$1
    local node=$2

    git show-ref --quiet --verify refs/heads/$leaf \
        || git show-ref --quiet --verify refs/tags/$leaf \
        || die "Reference '$leaf' doesn't exist"

    node=$(git rev-parse $node)

    git merge-base --is-ancestor $node $leaf >& /dev/null \
        || die "'$from' is not a child of '$leaf'"

    git diff-index --quiet HEAD -- \
        || die "Working dir's not in a clean state, please stash"
    #git stash push -u -m "Stashed before Elm-format applied on tree"

    git checkout --quiet $leaf \
        || die "Checkout of leaf commit '$leaf' failed"

    # git rev-list b1d51e5..feat/local-campaigns ^$node

    previous=""
    while [[ "$node" != "$previous" ]]
    do
        previous=$(git rev-parse HEAD~)
        new=$(apply-elm-format-to-a-commit $previous)

#       git cherry-pick $leaf ^$node \
#           || die "Cherry picking of '$leaf' to '$previous' on '$new' failing"

        if [[ $new != $previous ]]
        then
            git checkout $leaf \
                || die "Checkout of leaf commit '$leaf' failed"
            git rebase --onto $new $previous \
                || die "Rebase of '$leaf' on '$new' failing"
        fi
    done
}

apply-elm-format-to-a-commit()
{
    target=$1     # Target to inspect

    git checkout --quiet $target \
        || die "Checkout of node '$target' failed"

    ref=$(git rev-parse HEAD)
    files=$(git diff --name-only "$ref"~ "$ref" | grep \.elm)

    if [[ "" == "$files" ]]
    then
        return
    fi

    $ELMFORMAT --yes $files 2>&1 > /dev/null \
        || die "Elm format failed for '$ref' on files:\n--- 8< ---\n$files\n--- >8 ---"

    git diff-index --quiet HEAD --
    if [[ $? ]]
    then
        git add $files 2>&1 > /dev/null
        git commit --amend --no-edit 2>&1 > /dev/null
    fi

    new=$(git rev-parse HEAD)

    echo $new
}

main $@
