#!/bin/bash

set -e

for file in $@
do
	# From https://itextpdf.com/en/blog/technical-notes/how-completely-remove-file-git-repository
	git filter-branch -f \
		--prune-empty \
		--tag-name-filter cat \
		--tree-filter "rm -f $file" \
		-- --all

	git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
	git reflog expire --expire=now --all
	git gc --prune=now --aggressive
done
