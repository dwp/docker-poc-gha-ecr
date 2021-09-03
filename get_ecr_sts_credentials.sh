#!/bin/sh

set -euo pipefail

DURATION="${ASSUME_DURATION:=900}"
ROLE_ARN="arn:aws:iam::$1:role/gha_ecr"
AWS_STS=$(aws sts assume-role --role-arn "$ROLE_ARN" --role-session-name awscli-$(date +%m%d%y%H%M%S) --duration-seconds ${DURATION})

SECRET_ACCESS_KEY=$(echo $AWS_STS | jq .Credentials.SecretAccessKey -r)
ACCESS_KEY_ID=$(echo $AWS_STS | jq .Credentials.AccessKeyId -r)
SESSION_TOKEN=$(echo $AWS_STS | jq .Credentials.SessionToken -r)

cat <<EOT
{
  "access_key_id": "$ACCESS_KEY_ID",
  "secret_access_key": "$SECRET_ACCESS_KEY",
  "session_token": "$SESSION_TOKEN"
}
EOT
