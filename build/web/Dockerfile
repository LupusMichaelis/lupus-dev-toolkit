FROM httpd:2.4-alpine

# Apache with PHP5 module
RUN apk update && \
	apk add php5-apache2

# Tweak Apache
RUN sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf

# Tweak PHP5
RUN sed -i \
	-e 's/\(max_input_vars\)\s*=\s*\d+/\1=10000/' \
	-e 's/\(memory_limit\)\s*=\s*.*\(;\?\)/\1=2G\2/' \
	-e 's/\(upload_max_filesize\)=.*/\1\(;\?\)=40M/' \
		/etc/php5/php.ini;

# Debug settings
## TODO: web-dev Dockerfile

RUN sed -i \
	-e 's/\(error_reporting\)\s=\s.*\(;\?\)/\1=E_ALL\2/' \
	-e 's/\(log_errors\)\s*=\s*.*\(;\?\)/\1=On\2/' \
	-e 's/\(display_errors\)\s*=\s*.*\(;\?\)/\1=Off\2/' \
		/etc/php5/php.ini;
