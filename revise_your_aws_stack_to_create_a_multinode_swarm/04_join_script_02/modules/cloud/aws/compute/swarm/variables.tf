# in modules/cloud/aws/compute/swarm/variables.tf

variable "private_key_path" {
  description = "The path to the private key file."
  type        = string
}

variable "number_of_nodes" {
  description = "The number of nodes to create."
  type        = number
  default     = 3

  validation {
    condition     = var.number_of_nodes % 2 == 1
    error_message = "The number_of_nodes value must be an odd number."
  }
}

variable "account_id" {
  type        = string
  description = "AWS account ID"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}
