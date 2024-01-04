
## Retrieve GitLab Docker image default config files
```
DOCKER_IMAGE_TAG_GITLAB=latest
GITLAB_CONFIGS_DIR=configs
GITLAB_BIND_MOUNTS_DIR=bind_mounts

mkdir "${GITLAB_CONFIGS_DIR}"

{ docker run --rm gitlab/gitlab-ce:${DOCKER_IMAGE_TAG_GITLAB} cat /opt/gitlab/etc/gitlab.rb.template ;} \
	> "${GITLAB_CONFIGS_DIR}/gitlab.rb"

mkdir "${GITLAB_BIND_MOUNTS_DIR}"

{ docker run --rm gitlab/gitlab-ce:${DOCKER_IMAGE_TAG_GITLAB} cat /assets/wrapper ;} \
	> "${GITLAB_BIND_MOUNTS_DIR}/wrapper"
chmod 0755 "${GITLAB_BIND_MOUNTS_DIR}/wrapper"
```

## Print GitLab self-signed SSL certificate
```
DEVOPS_DOMAIN_NAME=example.com
GITLAB_SUBDOMAIN_NAME=gitlab
GITLAB_HOME=/srv/gitlab

openssl x509 -in ${GITLAB_HOME}/config/ssl/${GITLAB_SUBDOMAIN_NAME}.${DEVOPS_DOMAIN_NAME}.crt -noout -text
```

