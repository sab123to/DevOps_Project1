resource "aws_route_table" "eks-route-table-private" {
    vpc_id = var.eks_vpc_id

    route = [
        {
            cidr_block                    = "0.0.0.0/0"
            nat_gateway_id                = aws_nat_gateway.nat.id
            carrier_gateway_id            = ""
            core_network_arn              = ""
            destination_prefix_list_id    = ""
            egress_only_gateway_id        = ""
            gateway_id                    = ""
            ipv6_cidr_block               = ""
            local_gateway_id              = ""
            network_interface_id          = ""
            transit_gateway_id            = ""
            vpc_endpoint_id               = ""
            vpc_peering_connection_id     = ""
        },
    ]

    tags = {
        Name = "rtb-private"
    }
}


resource "aws_route_table" "eks-route-table-public" {
    vpc_id = var.eks_vpc_id

    route = [
        {
            cidr_block                    = "0.0.0.0/0"
            nat_gateway_id                = aws_nat_gateway.nat.id
            carrier_gateway_id            = ""
            core_network_arn              = ""
            destination_prefix_list_id    = ""
            egress_only_gateway_id        = ""
            gateway_id                    = ""
            ipv6_cidr_block               = ""
            local_gateway_id              = ""
            network_interface_id          = ""
            transit_gateway_id            = ""
            vpc_endpoint_id               = ""
            vpc_peering_connection_id     = ""
        },
    ]

    tags = {
        Name = "rtb-public"
    }
}


resource "aws_route_table_association" "private-eu-west-1a" {
  subnet_id = aws_subnet.private-eks-subnet1.id
  route_table_id = aws_route_table.eks-route-table-private.id
}

resource "aws_route_table_association" "private-eu-west-1b" {
  subnet_id = aws_subnet.private-eks-subnet2.id
  route_table_id = aws_route_table.eks-route-table-private.id
}

resource "aws_route_table_association" "public-eu-west-1a" {
  subnet_id = aws_subnet.public-eks-subnet1.id
  route_table_id = aws_route_table.eks-route-table-public.id
}

resource "aws_route_table_association" "public-eu-west-1b" {
  subnet_id = aws_subnet.public-eks-subnet2.id
  route_table_id = aws_route_table.eks-route-table-public.id
}
