
## Database(s)
```
DEVOPS_PROJECT_RESOURCES_DIR=~/Documents/devops_project_resources

cat <<_EOF
Driver: PostgreSQL
Host: postgres_gitlab
Port: 5432
Database: gitlabhq_production
User name: gitlab
User password: $( sudo cat "${DEVOPS_PROJECT_RESOURCES_DIR}/passwords/postgres/gitlab_password.txt" )
_EOF
cat <<_EOF
Driver: PostgreSQL
Host: postgres_redmine
Port: 5432
Database: redmine_db
User name: redmine
User password: $( sudo cat "${DEVOPS_PROJECT_RESOURCES_DIR}/passwords/postgres/redmine_password.txt" )
_EOF
```

[Docker Docs - Manual - Docker Engine - Containers - Running containers - Overriding image defaults](https://docs.docker.com/engine/reference/run/#default-command-and-options)  
```
DOCKER_IMAGE_TAG_CLOUDBEAVER=latest

docker run --rm --entrypoint='' dbeaver/cloudbeaver:${DOCKER_IMAGE_TAG_CLOUDBEAVER} cat /opt/cloudbeaver/run-server.sh
```

[DBeaver - Documentation - CloudBeaver - Configuration - Server configuration - Database Initial Data](https://dbeaver.com/docs/cloudbeaver/Server-configuration/#database-initial-data)  
```
DOCKER_IMAGE_TAG_CLOUDBEAVER=latest

{ docker run --rm --entrypoint='' dbeaver/cloudbeaver:${DOCKER_IMAGE_TAG_CLOUDBEAVER} cat /opt/cloudbeaver/conf/cloudbeaver.conf ;} \
	> configs/cloudbeaver.conf

{ docker run --rm --entrypoint='' dbeaver/cloudbeaver:${DOCKER_IMAGE_TAG_CLOUDBEAVER} cat /opt/cloudbeaver/conf/initial-data.conf ;} \
	> configs/initial-data.conf

{ docker run --rm --entrypoint='' dbeaver/cloudbeaver:${DOCKER_IMAGE_TAG_CLOUDBEAVER} cat /opt/cloudbeaver/conf/initial-data-sources.conf ;} \
	> configs/initial-data-sources.conf
```

[DBeaver - Documentation - CloudBeaver - Configuration - CloudBeaver and Nginx](https://dbeaver.com/docs/cloudbeaver/CloudBeaver-and-Nginx/)  

