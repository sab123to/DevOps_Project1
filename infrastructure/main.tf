provider "aws" {
    region = "eu-west-2"
}



resource "aws_vpc" "project_vpc" {
    cidr_block  = var.vpc_cidr_block
    tags = {
      Name: "lamp-vpc"
    }
}


module "my-project-subnet" {
    source                = "./modules/subnet"
    subnet_cidr_block     = var.subnet_cidr_block
    avail_zone            = var.avail_zone
    vpc_id                = aws_vpc.project_vpc.id
}


module "my-project-servers" {
    source                = "./modules/project-servers"
    vpc_id                = aws_vpc.project_vpc.id
    subnet_id             = module.my-project-subnet.subnet.id
    local_ip_addr         = var.local_ip_addr
    public_key_location   = var.public_key_location
    instance_type         = var.instance_type 
    avail_zone            = var.avail_zone
}
