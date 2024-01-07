#!/bin/sh

# man docker-container-diff

set -e
set -u

G_SNAPSHOTS_DIR=/tmp/dir_snapshots
G_SNAPSHOT_SOURCE_DIRECTORY=''

G_DATE=$( date '+%Y%m%d_%H%M%S' )

log_info () {
	echo "${@}"
}

log_warning () {
	echo "${@}" >&2
}

log_error () {
	echo "${@}" >&2
}

usage () {
	cat <<_EOF
usage: ${0} <directory>
_EOF
}

parse_snapshot_args () {
	G_SNAPSHOT_SOURCE_DIRECTORY="${1}"
	if [ ! -d "${G_SNAPSHOT_SOURCE_DIRECTORY}" ]
	then
		log_error "${G_SNAPSHOT_SOURCE_DIRECTORY} does not exist or is not a directory"
		exit 1
	fi
}

compute_snapshot () {
	local L_SNAPSHOT_TARGET_FILE="${G_SNAPSHOTS_DIR}/$( realpath -z "${G_SNAPSHOT_SOURCE_DIRECTORY}" | xargs -0 basename )_${G_DATE}"

	mkdir -p "${G_SNAPSHOTS_DIR}"

	sudo find "${G_SNAPSHOT_SOURCE_DIRECTORY}" \
		-type f \
		-exec sha1sum '{}' \; \
		| tee -a "${L_SNAPSHOT_TARGET_FILE}"

	log_info "Snapshot file: ${L_SNAPSHOT_TARGET_FILE}"
}

main () {
	if [ ${#} -lt 1 ]
	then
		usage
	else
		parse_snapshot_args "${@}"
		compute_snapshot
	fi
}

main "${@}"

