#/bin/sh

set -e
set -u

G_GITLAB_RB_TEMPLATE_FILE=/tmp/gitlab.rb.template
G_OMNIBUS_CONFIG_RB_FILE=/omnibus_config.rb

awk \
	' \
		/^[^#]/ \
		{ \
			sub(/\${HOSTNAME}/, "'"${HOSTNAME}"'"); \
			sub(/\${GITLAB_CONVEYED_WEB_PORT}/, "'"${GITLAB_CONVEYED_WEB_PORT}"'"); \
			sub(/\${GITLAB_CONVEYED_SSH_PORT}/, "'"${GITLAB_CONVEYED_SSH_PORT}"'"); \
			print $0; \
		} \
	' \
	"${G_GITLAB_RB_TEMPLATE_FILE}" \
	> "${G_OMNIBUS_CONFIG_RB_FILE}"
chmod 0600 "${G_OMNIBUS_CONFIG_RB_FILE}"

