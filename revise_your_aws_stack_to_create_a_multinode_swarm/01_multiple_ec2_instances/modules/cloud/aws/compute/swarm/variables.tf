# START: number_of_nodes
# in modules/cloud/aws/compute/swarm/variables.tf
# END: number_of_nodes

variable "private_key_path" {
  description = "The path to the private key file."
  type        = string
}

# START: number_of_nodes
variable "number_of_nodes" {
  description = "The number of nodes to create."
  type        = number
  default     = 3
}
# END: number_of_nodes
