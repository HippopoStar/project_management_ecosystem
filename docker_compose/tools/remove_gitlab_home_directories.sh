#!/bin/sh

set -e
set -u

GITLAB_HOME=/srv/gitlab

remove_directory () {
	local DIR_NAME="${1}"

	sudo chown -R $(id --user):$(id --group) "${GITLAB_HOME}/${DIR_NAME}"
	rm --recursive --force "${GITLAB_HOME}/${DIR_NAME}"
	mkdir "${GITLAB_HOME}/${DIR_NAME}"
}

remove_directory 'config'
remove_directory 'logs'
remove_directory 'data'

