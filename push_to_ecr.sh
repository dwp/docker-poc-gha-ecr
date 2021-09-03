#!/bin/bash

set -euo pipefail

# Build the image
docker build -t $IMAGE_NAME .

# Setup AWS credentials  and URLs etc
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_REGION
ACCOUNT="$(aws sts get-caller-identity | jq -r .Account)"
REG_URL="${ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com"

# Login to ECR
aws ecr get-login-password --region "$AWS_REGION" | \
  docker login --username AWS --password-stdin "$REG_URL"

# Tag and push
for TAG in "latest" "$SEM_VER" ; do 
  docker tag "$IMAGE_NAME" "$REG_URL:$TAG"
  docker push "$REG_URL:$TAG" | sed "s/$ACCOUNT/XXXXXXXX/"
done

# Complete
exit 0
