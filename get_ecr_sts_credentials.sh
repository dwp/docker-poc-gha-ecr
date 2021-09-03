#!/bin/sh

set -euo pipefail

#No debug printing!
set +x

DURATION="${ASSUME_DURATION:=900}"
MGMT_ACCOUNT="$(cat terraform.tf | grep -i "configured for .* account" | sed 's/.*[^0-9]//')"
ROLE_ARN="arn:aws:iam::$MGMT_ACCOUNT:role/gha_ecr"
AWS_STS=$(aws sts assume-role --role-arn "$ROLE_ARN" --role-session-name awscli-$(date +%m%d%y%H%M%S) --duration-seconds ${DURATION})

SECRET_ACCESS_KEY=$(echo $AWS_STS | jq .Credentials.SecretAccessKey -r)
ACCESS_KEY_ID=$(echo $AWS_STS | jq .Credentials.AccessKeyId -r)
SESSION_TOKEN=$(echo $AWS_STS | jq .Credentials.SessionToken -r)

cat > gha_ecr_sts_creds <<EOT
export TF_VAR_dev_gha_ecr_sts_creds="{
  access_key_id=\"$ACCESS_KEY_ID\"
  secret_access_key=\"$SECRET_ACCESS_KEY\"
  session_token=\"$SESSION_TOKEN\"
}"
EOT
