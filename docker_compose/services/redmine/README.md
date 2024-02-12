
```
DOCKER_IMAGE_TAG_REDMINE=latest

docker run --rm redmine:${DOCKER_IMAGE_TAG_REDMINE} cat /docker-entrypoint.sh
```

[Redmine - User's Guide - Installation guide - Installing Redmine - Configuration](https://www.redmine.org/projects/redmine/wiki/RedmineInstall#Configuration)  
```
DOCKER_IMAGE_TAG_REDMINE=latest

{ docker run --rm redmine:${DOCKER_IMAGE_TAG_REDMINE} cat /usr/src/redmine/config/configuration.yml.example ;} \
	> configs/configuration.yml
```

