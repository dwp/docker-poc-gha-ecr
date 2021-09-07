# docker-poc-gha-ecr

## A proof of concept repository for building a docker image in GHA and pushing to ECR with secure STS credentials

This repo contains Makefile, and Dockerfile to fit the standard pattern.
This repo is a base to create new Docker image repos, adding the githooks submodule, making the repo ready for use.

After cloning this repo, please run:  
`make bootstrap`

## Building Docker images for ECR in GitHub Actions

This repo contains a proof of concept code that works as follows:

* A change to the Dockerfile is pushed to the repo.
* The concourse pipeline kicks in:
  * After the bootstrap but before terraform runs, we add a job that generates 30min STS credentials providing ECR access.
  * Terraform ensures the ECR repo exists.
  * The management job adds the ECR credentials created above as github secrets.
  * Once terraform completes, Concourse triggers the Github workflow to build the image.
  * Finally, the workflow uses the ECR secrets to push the built image to ECR.
