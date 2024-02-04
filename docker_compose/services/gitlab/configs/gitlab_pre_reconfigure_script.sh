#/bin/sh

set -e
set -u

G_GITLAB_RB_TEMPLATE_FILE=/tmp/gitlab.rb.template
G_OMNIBUS_CONFIG_RB_TEMPLATE_FILE=/tmp/omnibus_config.rb.template
G_OMNIBUS_CONFIG_RB_FILE=/omnibus_config.rb

grep \
	-e '^[^#]' \
	"${G_GITLAB_RB_TEMPLATE_FILE}" \
	> "${G_OMNIBUS_CONFIG_RB_TEMPLATE_FILE}"
chmod 0600 "${G_OMNIBUS_CONFIG_RB_TEMPLATE_FILE}"
sed \
	-e 's/${HOSTNAME}/'"${HOSTNAME}"'/' \
	"${G_OMNIBUS_CONFIG_RB_TEMPLATE_FILE}" \
	> "${G_OMNIBUS_CONFIG_RB_FILE}"
chmod 0600 "${G_OMNIBUS_CONFIG_RB_FILE}"

