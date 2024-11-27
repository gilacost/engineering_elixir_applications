# START: number_of_nodes_validation
# START: account_id_region 
# in modules/cloud/aws/compute/swarm/variables.tf
# END: number_of_nodes_validation
# END: account_id_region

variable "private_key_path" {
  description = "The path to the private key file."
  type        = string
}

# START: number_of_nodes_validation
variable "number_of_nodes" {
  description = "The number of nodes to create."
  type        = number
  default     = 3

  validation {
    condition     = var.number_of_nodes % 2 == 1
    error_message = "The number_of_nodes value must be an odd number."
  }
}
# END: number_of_nodes_validation

# START: account_id_region
variable "account_id" {
  type        = string
  description = "AWS account ID"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}
# END: account_id_region
