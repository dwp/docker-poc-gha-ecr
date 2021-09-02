provider "github" {
  token        = var.github_token
  organization = var.github_organization
  version      = "~> 2.6.1"
}

data "external" "dev_gha_ecr_sts_creds" {
  program = ["${path.module}/scripts/get_ecr_sts_credentials.sh", lookup(local.account, "management-dev")]
}


resource "github_actions_secret" "dev_ecr_temp_access_key_id" {
  repository      = "docker-pod-gha-ecr"
  secret_name     = "DEV_AWS_ECR_TEMP_ACCESS_KEY_ID"
  plaintext_value = var.dev_temporary_ecr_access_credentials.access_key_id
}

resource "github_actions_secret" "dev_ecr_temp_access_secret_key" {
  repository      = "docker-pod-gha-ecr"
  secret_name     = "DEV_AWS_ECR_TEMP_SECRET_ACCESS_KEY"
  plaintext_value = var.dev_temporary_ecr_access_credentials.secret_access_key
}

resource "github_actions_secret" "dev_ecr_temp_access_session_token" {
  repository      = "docker-pod-gha-ecr"
  secret_name     = "DEV_AWS_ECR_TEMP_SESSION_TOKEN"
  plaintext_value = var.dev_temporary_ecr_access_credentials.session_token
}

