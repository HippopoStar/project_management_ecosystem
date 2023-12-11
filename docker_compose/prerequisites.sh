#!/bin/bash

set -o nounset
set -o errexit

trap on_exit EXIT

on_exit () {
	local EXIT_STATUS=${?}

	set +o nounset
	set +o errexit

	echo "Exit status: ${EXIT_STATUS}"
	echo 'If no error occured, you can now run docker-compose!'
	exit ${EXIT_STATUS}
}

# from '.env'
GITLAB_HOME=/srv/gitlab

docker_compose_v1_requirements () {
	if [ -z "$( which 'docker' )" ]
	then
		# https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script
		curl -fsSL https://get.docker.com -o get-docker.sh
		sudo sh ./get-docker.sh
		sudo groupadd docker
		sudo usermod -aG docker ${USER}
		echo 'User added to the "docker" group.'
		echo 'Log out and log back in so that your group membership is re-evaluated.'
		echo '(You can alternatively run "exec su - ${USER}")'
	fi
	if [ -z "$( which 'docker-compose' )" ]
	then
		if [ -z "$( which 'pip3' )" ]
		then
			sudo apt-get update && sudo apt-get install -y python3-pip
		fi
		python3 -m pip install --upgrade pip
		python3 -m pip install docker-compose
	fi
}

docker_compose_v2_requirements () {
	local DOCKER_STATUS
	local DOCKER_COMPOSE_STATUS
	local DOCKER_DESKTOP_STATUS
	get_package_status 'docker-ce' 'DOCKER_STATUS'
	get_package_status 'docker-compose-plugin' 'DOCKER_COMPOSE_STATUS'
	get_package_status 'docker-desktop' 'DOCKER_DESKTOP_STATUS'
	echo "docker-ce: ${DOCKER_STATUS:-not installed}"
	echo "docker-compose-plugin: ${DOCKER_COMPOSE_STATUS:-not installed}"
	echo "docker-desktop: ${DOCKER_DESKTOP_STATUS:-not installed}"
	if [ -z "${DOCKER_DESKTOP_STATUS}" ]
	then
		cat <<_EOF
Docker Desktop appears not to be installed.
To install Docker Desktop (recommanded), follow the instructions at:
https://docs.docker.com/compose/install/#scenario-one-install-docker-desktop
_EOF
	fi
}

get_package_status () {
	local PACKAGE_NAME="${1}"
	local -n PACKAGE_STATUS="${2}" # man bash - nameref
	PACKAGE_STATUS="$( dpkg-query --show --showformat='${db:Status-Status}\n' "${PACKAGE_NAME}" 2>/dev/null || true )"
}

gitlab_requirements () {
	sudo mkdir --parents "${GITLAB_HOME}"
	sudo chown "$( id --user ):$( id --group )" "${GITLAB_HOME}"
}

main () {
	# docker_compose_v1_requirements
	docker_compose_v2_requirements
	# gitlab_requirements
}

main "${@}"

