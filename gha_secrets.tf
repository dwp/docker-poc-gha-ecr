
resource "github_actions_secret" "dev_ecr_temp_access_key_id" {
  count		  = terraform.workspace == "management" ? 1 : 0
  repository      = local.name
  secret_name     = "DEV_AWS_ECR_TEMP_ACCESS_KEY_ID"
  plaintext_value = var.dev_gha_ecr_sts_creds.access_key_id
}

resource "github_actions_secret" "dev_ecr_temp_access_secret_key" {
  count		  = terraform.workspace == "management" ? 1 : 0
  repository      = local.name
  secret_name     = "DEV_AWS_ECR_TEMP_SECRET_ACCESS_KEY"
  plaintext_value = var.dev_gha_ecr_sts_creds.secret_access_key
}

resource "github_actions_secret" "dev_ecr_temp_access_session_token" {
  count		  = terraform.workspace == "management" ? 1 : 0
  repository      = local.name
  secret_name     = "DEV_AWS_ECR_TEMP_SESSION_TOKEN"
  plaintext_value = var.dev_gha_ecr_sts_creds.session_token
}

resource "github_actions_secret" "dev_aws_account" {
  count		  = terraform.workspace == "management" ? 1 : 0
  repository      = local.name
  secret_name     = "DEV_AWS_ACCOUNT"
  plaintext_value = var.dev_gha_ecr_sts_creds.aws_account
}

resource "github_actions_secret" "ecr_temp_access_key_id" {
  count		  = terraform.workspace == "management" ? 1 : 0
  repository      = local.name
  secret_name     = "AWS_ECR_TEMP_ACCESS_KEY_ID"
  plaintext_value = var.gha_ecr_sts_creds.access_key_id
}

resource "github_actions_secret" "ecr_temp_access_secret_key" {
  count		  = terraform.workspace == "management" ? 1 : 0
  repository      = local.name
  secret_name     = "AWS_ECR_TEMP_SECRET_ACCESS_KEY"
  plaintext_value = var.gha_ecr_sts_creds.secret_access_key
}

resource "github_actions_secret" "ecr_temp_access_session_token" {
  count		  = terraform.workspace == "management" ? 1 : 0
  repository      = local.name
  secret_name     = "AWS_ECR_TEMP_SESSION_TOKEN"
  plaintext_value = var.gha_ecr_sts_creds.session_token
}

resource "github_actions_secret" "aws_account" {
  count		  = terraform.workspace == "management" ? 1 : 0
  repository      = local.name
  secret_name     = "AWS_ACCOUNT"
  plaintext_value = var.gha_ecr_sts_creds.aws_account
}
