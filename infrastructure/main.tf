provider "aws" {
    region = "eu-west-3"
}


resource "aws_vpc" "project_vpc" {
    cidr_block  = "10.0.0.0/16"
    tags = {
      Name: "lamp-vpc"
    }
}


resource "aws_subnet" "project_subnet" {
    vpc_id               = aws_vpc.project_vpc.id
    cidr_block           = "10.0.10.0/24"
    availability_zone    = "eu-west-3a"
    tags = {
      Name: "lamp-subnet"
    }
}


resource "aws_route_table" "project-route-table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-internet_gateway.id
  }
  tags = {
    Name: "project-rtb"
  }
}


resource "aws_internet_gateway" "project-internet_gateway" {
  vpc_id = aws_vpc.project_vpc.id
  tags = {
    Name: "project-igw"
  }
}


resource "aws_route_table_association" "a-rtb" {
  subnet_id = aws_subnet.project_subnet.id
  route_table_id = aws_route_table.project-route-table.id
}


resource "aws_security_group" "example" {
  name = "project-sg"
  vpc_id = aws_vpc.project_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0            
    to_port     = 0            
    protocol    = "-1"            
    cidr_blocks = ["0.0.0.0/0"]  
    prefix_list_ids = []
  }

  tags = {
    Name: "project-sg"
  }
}


data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

resource "aws_instance" "project-server" {
  ami = data.aws_ami.latest-amazon-linux-image.id
}



