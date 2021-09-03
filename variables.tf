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

variable "dev_gha_ecr_sts_creds" {
  type        = object({
      access_key_id = string
      secret_access_key = string
      session_token = string
  })
}
