# in modules/cloud/aws/compute/swarm/variables.tf

variable "private_key_path" {
  description = "The path to the private key file."
  type        = string
}

variable "number_of_nodes" {
  description = "The number of nodes to create."
  type        = number
  default     = 3
}
