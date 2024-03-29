#!/usr/bin/env bash

# main function controls execution flow

# lp stands for Lupus Michaelis
# ep stands for entry point

. "$LUPUSMICHAELIS_DIR/library.sh"

[[ ! -z "$DEBUG" ]] \
	&& set -ex

lp-ep-get-all()
{
	find "$LUPUSMICHAELIS_DOCKER_ENTRIES_DIR" \
		-regex '.*/[0-9]\+_.*' \
		-exec basename '{}' \; \
		"$@"
}

lp-ep-get-last()
{
	lp-ep-get-all \
		-print \
		-quit \
		| head -1 \
		| awk -F'[/_]' '{print $(NF-1)}'
}


lp-ep-shift-files()
{
	for file in $(lp-ep-get-all)
	do
		mv \
			"$LUPUSMICHAELIS_DOCKER_ENTRIES_DIR/$file" \
			"$LUPUSMICHAELIS_DOCKER_ENTRIES_DIR/0$file"
	done
}

lp-ep-get-next-in-sequence()
{
	echo $(( $(lp-ep-get-last) + 1 ))
}

lp-is-non-zero-power-of()
{
	local -r power=$1
	local -r next=$2
	local -r size=${#next}

	if [[ 1 -eq "$size" ]]
	then
		false
		return
	fi

	if [[ 1 -ne "${next:0:1}" ]]
	then
		false
		return
	fi

	for position in $(seq 1 "$size" | tac)
	do
		if [[ 0 -ne ${next:$position:1} ]]
		then
			false
			return
		fi
	done

	true
	return
}

main()
{
	local -r source=$1
	shift

	[[ -x "$source" ]] \
		|| lp-die "Target should be an executable file"

	local -r next=$(lp-ep-get-next-in-sequence)

	# Ensure that the entry files are well aligned, to have chronology through a natural
	# sort
	lp-is-non-zero-power-of 10 "$next" \
		&& lp-ep-shift-files

	local -r target="$LUPUSMICHAELIS_DOCKER_ENTRIES_DIR/$next"_"$(basename "$source")"
	mv "$source" "$target"
}

main "$@"
