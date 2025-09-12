provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "DemoBucket"
    Environment = "Dev"
  }
}

resource "aws_instance" "terraform_demo_ec2_instance" {
    ami           = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    
    tags = {
        Name        = "TerraformDemoEC2Instance"
        Environment = "Dev"
    }
}

