#!/bin/sh

envsubst \
	'${DEVOPS_DOMAIN_NAME}:${GITLAB_SUBDOMAIN_NAME}:${REDMINE_SUBDOMAIN_NAME}:${CLOUDBEAVER_SUBDOMAIN_NAME}:${EXTERNAL_HTTPS_PORT}:${SERVER_CERTIFICATE}:${SERVER_CERTIFICATE_KEY}' \
	< /tmp/default.conf.placeholder \
	> /etc/nginx/conf.d/default.conf
chmod 0600 /etc/nginx/conf.d/default.conf

