variable "costcode" {
  type    = string
  default = ""
}

variable "assume_role" {
  type        = string
  default     = "ci"
  description = "IAM role assumed by Concourse when running Terraform"
}

variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "github_organization" {
  type        = string
  description = "GitHub Organisation to create repos in"
  default     = "dwp"
}

variable "github_token" {
  type        = string
  description = "GitHub personal access token for managing repos and committing code"
  default     = ""
}

variable "github_email" {
  type        = string
  description = "GitHub Email Address for committing code"
  default     = ""
}

variable "github_username" {
  type        = string
  description = "GitHub Username for committing code"
  default     = ""
}

variable "dev_gha_ecr_sts_creds" {
  type        = object({
      access_key_id = string
      secret_access_key = string
      session_token = string
  })
}
