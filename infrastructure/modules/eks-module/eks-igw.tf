resource "aws_internet_gateway" "igw" {
    vpc_id = var.eks_vpc_id

    tags = {
        Name = "igw"
    }
}