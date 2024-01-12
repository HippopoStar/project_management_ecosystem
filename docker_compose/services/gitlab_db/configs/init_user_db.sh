#!/bin/bash

set -e
set -u

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<_EOSQL
	CREATE USER gitlab WITH PASSWORD '$(< /run/secrets/gitlab_password)';
	CREATE DATABASE gitlabhq_production;
	GRANT ALL PRIVILEGES ON DATABASE gitlabhq_production TO gitlab;
_EOSQL

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname 'gitlabhq_production' <<_EOSQL
	CREATE EXTENSION IF NOT EXISTS pg_trgm;
	CREATE EXTENSION IF NOT EXISTS btree_gist;
	CREATE EXTENSION IF NOT EXISTS plpgsql;
_EOSQL

