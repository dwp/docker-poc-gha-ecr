# docker-poc-gha-ecr

## A proof of concept repository for building a docker image in GHA and pushing to ECR with secure STS credentials

This repo contains Makefile, and Dockerfile to fit the standard pattern.
This repo is a base to create new Docker image repos, adding the githooks submodule, making the repo ready for use.

After cloning this repo, please run:  
`make bootstrap`