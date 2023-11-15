#6)Create a NAT gateway for private subnets to access the internet

##########--- NAT Gateway ---##########

# Create Elastic IP for the NAT Gateway
resource "aws_eip" "elasticip_natgw" {
  vpc = true

  tags = {
    Project = "chupito"
  }
}

#Create NAT Gateway resource and attach it to the VPC and public subnet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elasticip_natgw.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Project = "chupito"
  }
}

##########--- RT Private Subnets ---##########
#Create a new Route Table 1 for Private Subnets
#Set as main route table, because you can use 
#NAT Gateway in all the public subnets, but 
#without main you only can use it with the 
#subnet where NAT Gateway is
resource "aws_route_table" "private_subnet_rt" {
  vpc_id = aws_vpc.vpc_aws.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Project = "chupito"
  }
}

# #Private subnets associated to private_subnet_rt
resource "aws_route_table_association" "private_subnets_associations" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_subnet_rt.id
}

