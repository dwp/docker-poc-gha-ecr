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
  type = string
}
