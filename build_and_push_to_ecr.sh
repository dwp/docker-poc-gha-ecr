#!/bin/bash

set -euo pipefail

# Build the image
cd build
docker build -t "$IMAGE_NAME" .

# Dev First
DEV_REG_URL="${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com"
AWS_ACCESS_KEY_ID="$DEV_AWS_ACCESS_KEY_ID" \
AWS_SECRET_ACCESS_KEY="$DEV_AWS_SECRET_ACCESS_KEY" \
AWS_SESSION_TOKEN="$DEV_AWS_SESSION_TOKEN" \
aws ecr get-login-password --region "$AWS_REGION" | \
docker login --username AWS --password-stdin "$DEV_REG_URL"

for TAG in "latest" "$SEM_VER" ; do 
  docker tag "$IMAGE_NAME" "$URL:$TAG"
  docker push "$URL:$TAG" | sed "s/$ACCOUNT/XXXXXXXX/"
done

# Live Second
REG_URL="${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com"
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
aws ecr get-login-password --region "$AWS_REGION" | \
docker login --username AWS --password-stdin "$REG_URL"

for TAG in "latest" "$SEM_VER" ; do
  docker tag "$IMAGE_NAME" "$URL:$TAG"
  docker push "$URL:$TAG" | sed "s/$ACCOUNT/XXXXXXXX/"
done

# Complete
exit 0
