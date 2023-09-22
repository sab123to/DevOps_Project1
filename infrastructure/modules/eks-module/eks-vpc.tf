resource "aws_vpc" "eks-vpc" {
    cidr_block = var.eks_vpc_cidr_block
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    

    tags = {
        "kubernetes.io/cluster/project-eks-cluster" = "shared"
    }

}

output "eks_vpc_id" {
  value = var.eks_vpc_id
}
