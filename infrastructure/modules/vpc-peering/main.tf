resource "aws_vpc" "project_vpc" {
    cidr_block  = var.vpc_cidr_block
    tags = {
      Name: "lamp-vpc"
    }
}


resource "aws_vpc" "eks-vpc" {
    cidr_block = var.eks_vpc_cidr_block
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    

    tags = {
        "kubernetes.io/cluster/project-eks-cluster" = "shared"
    }

}


resource "aws_vpc_peering_connection" "vpc_peering_ab" {
  vpc_id = var.vpc_id
  peer_vpc_id = var.eks_vpc_id
  auto_accept = true
}


resource "aws_vpc_peering_connection" "vpc_peering_ba" {
  vpc_id = var.eks_vpc_id
  peer_vpc_id = var.vpc_id
  auto_accept = true
}
