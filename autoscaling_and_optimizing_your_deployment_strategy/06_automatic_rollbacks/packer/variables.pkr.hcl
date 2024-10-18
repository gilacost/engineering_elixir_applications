# in packer/variables.pkr.hcl

variable "ami_regions" {
  type        = list(string)
  description = "A list of regions where the AMI will be copied to."
}
