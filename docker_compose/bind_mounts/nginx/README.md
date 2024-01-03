
## Retrieve NGINX Docker image default config files
```
DOCKER_IMAGE_TAG_NGINX=stable

mkdir docker_compose/bind_mounts/nginx

{ docker run --rm nginxinc/nginx-unprivileged:${DOCKER_IMAGE_TAG_NGINX} cat /etc/nginx/nginx.conf ;} \
	> docker_compose/bind_mounts/nginx/nginx.conf

mkdir docker_compose/bind_mounts/nginx/conf.d

{ docker run --rm nginxinc/nginx-unprivileged:${DOCKER_IMAGE_TAG_NGINX} cat /etc/nginx/conf.d/default.conf ;} \
	> docker_compose/bind_mounts/nginx/conf.d/default.conf
```

## Print GitLab self-signed SSL certificate
```
DEVOPS_DOMAIN_NAME=example.com
GITLAB_SUBDOMAIN_NAME=gitlab
GITLAB_HOME=/srv/gitlab

openssl x509 -in ${GITLAB_HOME}/config/ssl/${GITLAB_SUBDOMAIN_NAME}.${DEVOPS_DOMAIN_NAME}.crt -noout -text
```

## Append servers' addresses to `/etc/hosts`
```
DEVOPS_DOMAIN_NAME=example.com
GITLAB_SUBDOMAIN_NAME=gitlab

cat <<_EOF | sudo tee -a /etc/hosts
127.0.0.1     ${DEVOPS_DOMAIN_NAME}
127.0.0.1     ${GITLAB_SUBDOMAIN_NAME}.${DEVOPS_DOMAIN_NAME}
_EOF
```

