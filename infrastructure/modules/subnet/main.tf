resource "aws_subnet" "project_subnet" {
    vpc_id               = var.vpc_id
    cidr_block           = var.subnet_cidr_block
    availability_zone    = var.avail_zone
    tags = {
      Name: "lamp-subnet"
    }
}


resource "aws_route_table" "project-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-internet_gateway.id
  }
  tags = {
    Name: "project-rtb"
  }
}


resource "aws_route_table_association" "a-rtb" {
  subnet_id = aws_subnet.project_subnet.id
  route_table_id = aws_route_table.project-route-table.id
}


resource "aws_internet_gateway" "project-internet_gateway" {
  vpc_id = var.vpc_id
  tags = {
    Name: "project-igw"
  }
}


