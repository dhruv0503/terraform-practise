provider "aws" {
    region = var.aws_region
}

resource "aws_key_pair" "keypair" {
    key_name = "demo-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

module "network" {
    source = "./modules/network"
    vpc_cidr = "10.0.0.0/20"
    public_subnet_cidr = "10.0.1.0/24"
    private_subnet_cidr = "10.0.2.0/24"
    lb_public_subnet_cidr = "10.0.3.0/24"
}

module "instance" {
    source = "./modules/instance"
    instance_ami = "ami-0e35ddab05955cf57"
    vpc_id = module.network.vpc_id
    public_subnet_id = module.network.public_subnet
    private_subnet_id = module.network.private_subnet
    ssh_cidr = ["182.69.181.105/32"]
    instance_type = "t2.micro"
    lb_public_subnet_id = module.network.lb_public_subnet
    key_pair_name = aws_key_pair.keypair.key_name
}

output "instance_public_ip" {
    value = module.network.public_ip
}