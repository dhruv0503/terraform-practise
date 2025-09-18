variable "instance_ami" {
  description = "The AMI for the instance"
  type        = string
}

variable "private_subnet_id" {
  description = "Private Subnet ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "lb_public_subnet_id" {
  description = "Public Subnet ID for Load Balancer"
  type        = string
}

variable "vpc_id" {
  description = "The value of the VPC ID"
  type        = string
}

variable "ssh_cidr" {
  description = "List of cidr blocks to ssh into the instance"
  type        = list(string)
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string  
}

variable "key_pair_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  
}