resource "aws_subnet" "private-eks-subnet1" {
  vpc_id     = var.eks_vpc_id
  cidr_block = var.eks_subnet_cidr_block_priv1
  availability_zone = var.eks_subnet_avail_zone_priv1

  tags = {
    "Name"  = "private-eu-west-1a-subnet"
    "kubernetes.io/cluster/project-eks" = "owned"
    "kubernetes.io/role/internal-elb" = 1
  }
}



resource "aws_subnet" "private-eks-subnet2" {
  vpc_id     = var.eks_vpc_id
  cidr_block = var.eks_subnet_cidr_block_priv2
  availability_zone = var.eks_subnet_avail_zone_priv2

  tags = {
    "Name"  = "private-eu-west-1b-subnet"
    "kubernetes.io/cluster/project-eks" = "owned"
    "kubernetes.io/role/internal-elb" = 1
  }
}


resource "aws_subnet" "public-eks-subnet1" {
  vpc_id     = var.eks_vpc_id
  cidr_block = var.eks_subnet_cidr_block_pub1
  availability_zone = var.eks_subnet_avail_zone_pub1

  tags = {
    "Name"  = "public-eu-west-1a-subnet"
    "kubernetes.io/cluster/project-eks" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}


resource "aws_subnet" "public-eks-subnet2" {
  vpc_id     = var.eks_vpc_id
  cidr_block = var.eks_subnet_cidr_block_pub2
  availability_zone = var.eks_subnet_avail_zone_pub2

  tags = {
    "Name"  = "public-eu-west-1b-subnet"
    "kubernetes.io/cluster/project-eks" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}