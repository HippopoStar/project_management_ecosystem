
## Retrieve NGINX Docker image default config files
```
DOCKER_IMAGE_TAG_NGINX=stable
NGINX_CONFIGS_DIR=configs

mkdir "${NGINX_CONFIGS_DIR}"

{ docker run --rm nginxinc/nginx-unprivileged:${DOCKER_IMAGE_TAG_NGINX} cat /etc/nginx/nginx.conf ;} \
	> "${NGINX_CONFIGS_DIR}/nginx.conf"

mkdir "${NGINX_CONFIGS_DIR}/conf.d"

{ docker run --rm nginxinc/nginx-unprivileged:${DOCKER_IMAGE_TAG_NGINX} cat /etc/nginx/conf.d/default.conf ;} \
	> "${NGINX_CONFIGS_DIR}/conf.d/default.conf"
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
About wildcard subdomains, see [ArchLinux - Wiki - dnsmasq](https://wiki.archlinux.org/title/Dnsmasq)  

