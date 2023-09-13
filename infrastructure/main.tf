provider "aws" {
    region = "eu-west-2"
}

variable public_key_location {}
variable instance_type {}
variable avail_zone {}
variable subnet_cidr_block {}
variable vpc_cidr_block {}
variable local_ip_addr {}





resource "aws_vpc" "project_vpc" {
    cidr_block  = var.vpc_cidr_block
    tags = {
      Name: "lamp-vpc"
    }
}


resource "aws_subnet" "project_subnet" {
    vpc_id               = aws_vpc.project_vpc.id
    cidr_block           = var.subnet_cidr_block
    availability_zone    = var.avail_zone
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


resource "aws_security_group" "project-sg" {
  name = "project-sg"
  vpc_id = aws_vpc.project_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.local_ip_addr]
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
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516"]
    }
    filter {
          name = "image-id"
          values = ["ami-0eb260c4d5475b901"]
        }
    
}

resource "aws_key_pair" "ssh-key" {
    key_name = "project-key"
    public_key = file(var.public_key_location)
}


resource "aws_instance" "project-server" {
    ami                           = data.aws_ami.latest-amazon-linux-image.id
    instance_type                 = var.instance_type
    key_name                      = aws_key_pair.ssh-key.key_name
    associate_public_ip_address   = true
    subnet_id                     = aws_subnet.project_subnet.id
    vpc_security_group_ids        = [aws_security_group.project-sg.id]
    availability_zone             = var.avail_zone

    tags = {
      Name = "lamp1-server"
    }

}

resource "aws_instance" "project-server2" {
    ami                           = data.aws_ami.latest-amazon-linux-image.id
    instance_type                 = var.instance_type
    key_name                      = aws_key_pair.ssh-key.key_name
    associate_public_ip_address   = true
    subnet_id                     = aws_subnet.project_subnet.id
    vpc_security_group_ids        = [aws_security_group.project-sg.id]
    availability_zone             = var.avail_zone

    tags = {
      Name = "lamp2-server"
    }

}

resource "aws_instance" "project-server3" {
    ami                           = data.aws_ami.latest-amazon-linux-image.id
    instance_type                 = var.instance_type
    key_name                      = aws_key_pair.ssh-key.key_name
    associate_public_ip_address   = true
    subnet_id                     = aws_subnet.project_subnet.id
    vpc_security_group_ids        = [aws_security_group.project-sg.id]
    availability_zone             = var.avail_zone

    tags = {
      Name = "nginx-server"
    }

}
