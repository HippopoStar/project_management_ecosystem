
```
DOCKER_IMAGE_TAG_NGINX=stable

mkdir docker_compose/bind_mounts/nginx

{ docker run --rm nginxinc/nginx-unprivileged:${DOCKER_IMAGE_TAG_NGINX} cat /etc/nginx/nginx.conf ;} \
	> docker_compose/bind_mounts/nginx/nginx.conf

mkdir docker_compose/bind_mounts/nginx/conf.d

{ docker run --rm nginxinc/nginx-unprivileged:${DOCKER_IMAGE_TAG_NGINX} cat /etc/nginx/conf.d/default.conf ;} \
	> docker_compose/bind_mounts/nginx/conf.d/default.conf
```

```
GITLAB_HOME=/srv/gitlab

openssl x509 -in ${GITLAB_HOME}/config/ssl/gitlab.example.com.crt -noout -text
```
