#!/bin/bash

set -euo pipefail

# Build the image
docker build -t "$IMAGE_NAME" .

# Setup AWS credentials  and URLs etc
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
export AWS_REGION AWS_ACCOUNT DEV_AWS_ACCOUNT

REG_URL="${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com"
DEV_REG_URL="${DEV_AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com"

# Login to ECR
aws ecr get-login-password --region "$AWS_REGION" | \
  docker login --username AWS --password-stdin "$REG_URL"

# Tag and push
for TAG in "latest" "$SEM_VER" ; do 
  for URL in "$DEV_REG_URL" "$REG_URL" ; do
    docker tag "$IMAGE_NAME" "$URL:$TAG"
    docker push "$URL:$TAG" | sed "s/$ACCOUNT/XXXXXXXX/"
  done
done

# Complete
exit 0
