# in modules/integrations/github/contributing_workflow/variables.tf

variable "repository" {
  description = "Name of the GitHub repository."
  type        = string
}

variable "github_owner" {
  description = "Owner/organization where the GitHub repository resides."
  type        = string
}

variable "status_checks" {
  description = "List of required status checks that must pass."
  type        = list(string)
  default     = []
}
