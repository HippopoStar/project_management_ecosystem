#/bin/sh

set -e
set -u

G_GITLAB_RB_PLACEHOLDER_FILE=/tmp/gitlab.rb.placeholder
G_OMNIBUS_CONFIG_RB_FILE=/omnibus_config.rb

awk \
	' \
		/^[^#]/ \
		{ \
			sub(/\${HOSTNAME}/, "'"${HOSTNAME}"'"); \
			sub(/\${EXTERNAL_HTTPS_PORT}/, "'"${EXTERNAL_HTTPS_PORT}"'"); \
			sub(/\${EXTERNAL_SSH_PORT}/, "'"${EXTERNAL_SSH_PORT}"'"); \
			print $0; \
		} \
	' \
	"${G_GITLAB_RB_PLACEHOLDER_FILE}" \
	> "${G_OMNIBUS_CONFIG_RB_FILE}"
chmod 0600 "${G_OMNIBUS_CONFIG_RB_FILE}"

