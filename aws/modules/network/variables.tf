variable "vpc_cidr" {
    description = "The CIDR block for the VPC."
    type = string
}

variable "public_subnet_cidr" {
    description = "The CIDR block for the public subnet housing the Load Balancer."
    type = string
}

variable "lb_public_subnet_cidr" {
    description = "The CIDR block for the public subnet housing the Load Balancer."
    type = string
  
}

variable "private_subnet_cidr" {
  description = "This CIDR block for the private subnet housing the instance"
}