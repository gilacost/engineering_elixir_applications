# in environments/production/variables.tf

variable "aws_access_key_id" {
  description = "The AWS access key ID."
  type        = string
}

variable "aws_secret_access_key" {
  description = "The AWS secret access key."
  type        = string
  sensitive   = true
}

variable "age_key" {
  description = "The age key for sops encryption tool"
  type        = string
  sensitive   = true
}

variable "gh_pat" {
  description = "A GitHub personal access token. Used to log into ghcr.io."
  type        = string
  sensitive   = true
}

variable "account_id" {
  type        = string
  description = "AWS account ID"
}
