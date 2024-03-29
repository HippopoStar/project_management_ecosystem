#!/bin/sh

set -e
set -u

G_PASSWORDS_DIR=~/Documents/devops_project_resources/passwords

register_password () {
	local L_PASSWORD_DESC="${1}"
	local L_PASSWORD_FILE="${2}"
	local L_PASSWORD_DEFAULT_VALUE="${3}"
	local L_PASSWORD=''

	mkdir -p "${G_PASSWORDS_DIR}/${L_SERVICE_NAME}"
	if [ ! -f "${G_PASSWORDS_DIR}/${L_SERVICE_NAME}/${L_PASSWORD_FILE}" ]
	then
		read -p "Enter ${L_PASSWORD_DESC} [${L_PASSWORD_DEFAULT_VALUE}]: " L_PASSWORD
		if [ -z "${L_PASSWORD}" ]
		then
			L_PASSWORD="${L_PASSWORD_DEFAULT_VALUE}"
		fi
		echo "${L_PASSWORD}" > "${G_PASSWORDS_DIR}/${L_SERVICE_NAME}/${L_PASSWORD_FILE}"
		chmod 0600 "${G_PASSWORDS_DIR}/${L_SERVICE_NAME}/${L_PASSWORD_FILE}"
	fi
}

configure_gitlab_passwords () {
	local L_SERVICE_NAME='gitlab'

	register_password 'GitLab initial root password' 'initial_root_password.txt' '5iveL!fe'
}

configure_redmine_passwords () {
	local L_SERVICE_NAME='redmine'

	register_password 'Redmine administrator (admin) password' 'admin_password.txt' 'admin'
}

configure_cloudbeaver_passwords () {
	local L_SERVICE_NAME='cloudbeaver'

	register_password 'CloudBeaver administrator (cbadmin) password' 'cbadmin_password.txt' 'cbadmin20'
}

configure_postgres_passwords () {
	local L_SERVICE_NAME='postgres'

	register_password 'PostgreSQL password for superuser (postgres)' 'postgres_password.txt' $( pwgen -s 20 1 )
	sudo chown 999:999 "${G_PASSWORDS_DIR}/${L_SERVICE_NAME}/postgres_password.txt"

	register_password 'PostgreSQL password for GitLab (gitlab)' 'gitlab_password.txt' $( pwgen -s 20 1 )
	cp "${G_PASSWORDS_DIR}/${L_SERVICE_NAME}/gitlab_password.txt" "${G_PASSWORDS_DIR}/gitlab/postgres_password.txt"
	sudo chown 999:999 "${G_PASSWORDS_DIR}/${L_SERVICE_NAME}/gitlab_password.txt"

	register_password 'PostgreSQL password for Redmine (redmine)' 'redmine_password.txt' $( pwgen -s 20 1 )
	cp "${G_PASSWORDS_DIR}/${L_SERVICE_NAME}/redmine_password.txt" "${G_PASSWORDS_DIR}/redmine/postgres_password.txt"
	sudo chown 999:999 "${G_PASSWORDS_DIR}/${L_SERVICE_NAME}/redmine_password.txt"
	sudo chown 999:999 "${G_PASSWORDS_DIR}/redmine/postgres_password.txt"
}

main () {
	mkdir -p "${G_PASSWORDS_DIR}"

	configure_gitlab_passwords
	configure_redmine_passwords
	configure_cloudbeaver_passwords
	configure_postgres_passwords
}

main "${@}"

