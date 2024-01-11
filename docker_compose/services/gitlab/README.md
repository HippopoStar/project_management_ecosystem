
## Retrieve GitLab Docker image default config files
```
DOCKER_IMAGE_TAG_GITLAB=latest

{ docker run --rm gitlab/gitlab-ce:${DOCKER_IMAGE_TAG_GITLAB} cat /opt/gitlab/etc/gitlab.rb.template ;} \
	> configs/gitlab.rb
chmod 0600 configs/gitlab.rb

{ docker run --rm gitlab/gitlab-ce:${DOCKER_IMAGE_TAG_GITLAB} cat /assets/wrapper ;} \
	> configs/wrapper
chmod 0755 configs/wrapper
```

## Display uncommented lines in file gitlab.rb
```
grep -n -e '^[^#]' configs/gitlab.rb
```

## Print GitLab self-signed SSL certificate and NGINX configuration
```
DEVOPS_DOMAIN_NAME=example.com
GITLAB_SUBDOMAIN_NAME=gitlab
GITLAB_HOME=/srv/gitlab

openssl x509 -in "${GITLAB_HOME}/config/ssl/${GITLAB_SUBDOMAIN_NAME}.${DEVOPS_DOMAIN_NAME}.crt" -noout -text
cat "${GITLAB_HOME}/data/nginx/conf/gitlab-http.conf"
```

## Get initial root password
[GitLab - Product documentation - Administer - Administer users - Reset user password - Reset the root password](https://docs.gitlab.com/ee/security/reset_user_password.html#reset-the-root-password)  
[GitLab - GitLab.org - omnibus-gitlab - README.md - After installation](https://gitlab.com/gitlab-org/omnibus-gitlab#after-installation)  
[GitLab - GitLab.org - omnibus-gitlab - files/gitlab-config-template/gitlab.rb.template - L713](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template#L713)  
```
DOCKER_COMPOSE_SERVICE_GITLAB_NAME=gitlab

docker exec "${DOCKER_COMPOSE_SERVICE_GITLAB_NAME}" cat /etc/gitlab/initial_root_password
```

