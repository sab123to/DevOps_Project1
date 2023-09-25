# ec2 servers and subnet component variables
variable public_key_location {}
variable instance_type {}
variable avail_zone {}
variable subnet_cidr_block {}
variable vpc_cidr_block {}
variable local_ip_addr {}
variable vpc_id {}

# eks infrastructure variables
variable eks_vpc_id {}
variable eks_vpc_cidr_block {}
variable eks_subnet_cidr_block_priv1 {}
variable eks_subnet_cidr_block_priv2 {}
variable eks_subnet_cidr_block_pub1 {}
variable eks_subnet_cidr_block_pub2 {}
variable eks_subnet_avail_zone_priv1 {}
variable eks_subnet_avail_zone_priv2 {}
variable eks_subnet_avail_zone_pub1 {}
variable eks_subnet_avail_zone_pub2 {}