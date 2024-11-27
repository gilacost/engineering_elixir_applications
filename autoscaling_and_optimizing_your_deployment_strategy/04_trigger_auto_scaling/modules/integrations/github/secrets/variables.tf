# in modules/integrations/github/secrets/variables.tf

variable "secrets" {
  description = "A map of secrets to be created for a certain repository"
  type        = map(string)
}

variable "github_owner" {
  description = "The name of the GitHub organization."
  type        = string
}

variable "repository" {
  description = "The name of the GitHub repository."
  type        = string
}