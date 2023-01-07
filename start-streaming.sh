#!/usr/bin/env bash
set -euxo pipefail

REMOTE=$(terraform output --raw analytics_ip)
echo $REMOTE

# drop this IP from hosts
ssh-keygen -R $REMOTE || True

TMP_FILE=docker-compose.yml.tmp

cp docker-compose.yml $TMP_FILE
sed -i "s/PUBLIC_IP/$REMOTE/" $TMP_FILE

scp $TMP_FILE root@$REMOTE:docker-compose.yml
rm -rf $TMP_FILE

ssh root@$REMOTE 'docker compose up'
