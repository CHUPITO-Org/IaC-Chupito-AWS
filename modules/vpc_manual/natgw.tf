#6)Create a NAT gateway for private subnets to access the internet

##########--- NAT Gateway ---##########

# Create Elastic IP for the NAT Gateway
resource "aws_eip" "E_IPs_NATgw_chupito" {
  #count  = length(var.public_subnet_cidrs)
  vpc = true

  tags = {
    Name = "E-IPs-NATgw-chupito"
  }
}

#Create NAT Gateway resource and attach it to the VPC and public subnet
resource "aws_nat_gateway" "NAT_gateway_chupito" {
  allocation_id = aws_eip.E_IPs_NATgw_chupito.id
  subnet_id     = aws_subnet.public_subnets_chupito[0].id

  tags = {
    Name = "NAT-gateway-chupito"
  }
}

##########--- RT Private Subnets ---##########
#Create a new Route Table 1 for Private Subnets
#Set as main route table, because you can use 
#NAT Gateway in all the public subnets, but 
#without main you only can use it with the 
#subnet where NAT Gateway is
resource "aws_route_table" "PrivateSubRT" {
  #count      = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.vpc_aws_chupito.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT_gateway_chupito.id
  }

  tags = {
    Name = "PrivateSubRT"
  }
}

# #Private subnets associated to PublicSubRT
# resource "aws_route_table_association" "private_subnets_associations" {
#   count          = length(var.private_subnet_cidrs)
#   subnet_id      = element(aws_subnet.private_subnets_chupito[*].id, count.index)
#   route_table_id = aws_route_table.PrivateSubRT.id
# }
