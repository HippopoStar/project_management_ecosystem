#!/bin/sh

envsubst \
	'${GITLAB_SUBDOMAIN_NAME}:${DEVOPS_DOMAIN_NAME}:${GITLAB_CONVEYED_WEB_PORT}:${SERVER_CERTIFICATE}:${SERVER_CERTIFICATE_KEY}' \
	< /tmp/default.conf.placeholder \
	> /etc/nginx/conf.d/default.conf
chmod 0600 /etc/nginx/conf.d/default.conf

