#!/bin/sh

set -e
set -u

C_EOC='\033[0m'
C_BOLD='\033[1m'
C_BLACK='\033[30m'
C_RED='\033[31m'
C_GREEN='\033[32m'
C_YELLOW='\033[33m'
C_BLUE='\033[34m'
C_MAGENTA='\033[35m'
C_CYAN='\033[36m'
C_WHITE='\033[37m'

G_GITLAB_RB_TEMPLATE_FILE=/tmp/gitlab.rb.template
G_OMNIBUS_CONFIG_RB_FILE=/omnibus_config.rb

echo "${C_BOLD}${G_GITLAB_RB_TEMPLATE_FILE}${C_EOC}:"
grep -n -e '^[^#]' "${G_GITLAB_RB_TEMPLATE_FILE}"
echo "${C_BOLD}${G_OMNIBUS_CONFIG_RB_FILE}${C_EOC}:"
cat "${G_OMNIBUS_CONFIG_RB_FILE}"

