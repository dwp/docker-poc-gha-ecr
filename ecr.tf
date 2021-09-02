resource "aws_ecr_repository" "docker-poc-gha-ecr" {
  name = "docker-poc-gha-ecr"
  tags = merge(
    local.common_tags,
    { DockerHub : "dwpdigital/docker-poc-gha-ecr" }
  )
}

resource "aws_ecr_repository_policy" "docker-poc-gha-ecr" {
  repository = aws_ecr_repository.docker-poc-gha-ecr.name
  policy     = data.terraform_remote_state.management.outputs.ecr_iam_policy_document
}

output "ecr_example_url" {
  value = aws_ecr_repository.docker-poc-gha-ecr.repository_url
}
