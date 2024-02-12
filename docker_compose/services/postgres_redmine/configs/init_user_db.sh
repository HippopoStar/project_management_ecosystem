#!/bin/bash

set -e
set -u

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<_EOSQL
	CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD '$(< /run/secrets/redmine_password)' NOINHERIT VALID UNTIL 'infinity';
	CREATE DATABASE redmine_db WITH ENCODING='UTF8' OWNER=redmine;
	ALTER DATABASE "redmine_db" SET datestyle="ISO,MDY";
_EOSQL

