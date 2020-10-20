#!/usr/bin/env /bin/bash

set -e

[[ ! -z "$DEBUG" ]] \
	&& set -x

composer_setup="/tmp/composer-setup.php"
composer_filename="composer"

EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', '$composer_setup');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', '$composer_setup');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
	>&2 echo 'ERROR: Invalid installer checksum'
	rm $composer_setup
	exit 1
fi

php $composer_setup \
	--quiet \
	--filename="$composer_filename"
RESULT=$?
rm "$composer_setup"
mv "$composer_filename" "/usr/local/bin/$composer_filename"
chmod +x "/usr/local/bin/$composer_filename"

exit $RESULT
