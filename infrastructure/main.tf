provider "aws" {
    region = "eu-west-2"
}
 

module "vpc-peering" {
    source                 = "./modules/vpc-peering"
    vpc_cidr_block         = var.vpc_cidr_block
    eks_vpc_cidr_block     = var.eks_vpc_cidr_block
    vpc_id                 = var.vpc_id
    eks_vpc_id             = var.eks_vpc_id
}



module "my-project-subnet" {
    source                = "./modules/subnet"
    subnet_cidr_block     = var.subnet_cidr_block
    avail_zone            = var.avail_zone
    vpc_id                = module.vpc-peering.vpc_id
}


module "my-project-servers" {
    source                = "./modules/project-servers"
    vpc_id                = module.vpc-peering.vpc_id
    subnet_id             = module.my-project-subnet.subnet.id
    local_ip_addr         = var.local_ip_addr
    public_key_location   = var.public_key_location
    instance_type         = var.instance_type 
    avail_zone            = var.avail_zone
}

module "my-project-eks" {
     source                      = "./modules/eks-module"
     eks_vpc_id                  = module.vpc-peering.eks_vpc_id
     eks_vpc_cidr_block          = var.eks_vpc_cidr_block
     eks_subnet_cidr_block_priv1 = var.eks_subnet_cidr_block_priv1
     eks_subnet_cidr_block_priv2 = var.eks_subnet_cidr_block_priv2
     eks_subnet_cidr_block_pub1  = var.eks_subnet_cidr_block_pub1
     eks_subnet_cidr_block_pub2  = var.eks_subnet_cidr_block_pub2
     eks_subnet_avail_zone_priv1 = var.eks_subnet_avail_zone_priv1
     eks_subnet_avail_zone_priv2 = var.eks_subnet_avail_zone_priv2
     eks_subnet_avail_zone_pub1  = var.eks_subnet_avail_zone_pub1
     eks_subnet_avail_zone_pub2  = var.eks_subnet_avail_zone_pub2
}

