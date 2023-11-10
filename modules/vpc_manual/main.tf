

# #3) Create Internet Gateway (IGW)
# resource "aws_internet_gateway" "igw_aws" {
#  vpc_id = aws_vpc.vpc_aws.id

#  tags = {
#    Name = "VPC-igw"
#  }
# }

# #4) Create 2nd Route Table for Public Subnets, 
# #because before a 1st Route Table (Private Subnets)
# #was created with the resources above (default Route Table)
# resource "aws_route_table" "second_RT" {
#  vpc_id = aws_vpc.vpc_aws.id

#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.igw_aws.id
#  }

#  tags = {
#    Name = "Public_Subnets_RT"
#  }
# }

# #Public subnets associated to Public_Subnets_RT
# resource "aws_route_table_association" "public_subnets_associations" {
#  count          = length(var.public_subnet_cidrs)
#  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
#  route_table_id = aws_route_table.second_RT.id
# }

# #5)Network ACL is created by default
# /*resource "aws_network_acl" "public" {
#   vpc_id = aws_vpc.main.id

#   egress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 80
#     to_port    = 80
#   }

#   egress {
#     protocol   = "tcp"
#     rule_no    = 110
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 443
#     to_port    = 443
#   }

#   egress {
#     protocol   = "tcp"
#     rule_no    = 150
#     action     = "allow"
#     cidr_block = "10.0.1.0/24"
#     from_port  = 22
#     to_port    = 22

#   }

#   egress {
#     protocol   = "tcp"
#     rule_no    = 140
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 1024
#     to_port    = 65535

#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 120
#     action     = "allow"
#     cidr_block = var.public_ip
#     from_port  = 22
#     to_port    = 22

#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 80
#     to_port    = 80
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 110
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 443
#     to_port    = 443
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 140
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 1024
#     to_port    = 65535
#   }

#   tags = merge(var.project_tags, {
#     Name = "public-nacl"
#   })
# }

# resource "aws_network_acl" "private" {
#   vpc_id = aws_vpc.main.id

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "10.0.0.0/16"
#     from_port  = 1433
#     to_port    = 1433
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 120
#     action     = "allow"
#     cidr_block = "10.0.0.0/16"
#     from_port  = 22
#     to_port    = 22
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 130
#     action     = "allow"
#     cidr_block = "10.0.0.0/16"
#     from_port  = 3389
#     to_port    = 3389
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 140
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 1024
#     to_port    = 65535
#   }

#   egress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 80
#     to_port    = 80
#   }

#   egress {
#     protocol   = "tcp"
#     rule_no    = 110
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 443
#     to_port    = 443
#   }

#   egress {
#     protocol   = "tcp"
#     rule_no    = 120
#     action     = "allow"
#     cidr_block = "10.0.0.0/16"
#     from_port  = 32768
#     to_port    = 65535
#   }

#   tags = merge(var.project_tags, {
#     Name = "private-nacl"
#   })

# }

# resource "aws_network_acl_association" "public" {
#   network_acl_id = aws_network_acl.public.id
#   subnet_id      = aws_subnet.public.id
# }

# resource "aws_network_acl_association" "private" {
#   network_acl_id = aws_network_acl.private.id
#   subnet_id      = aws_subnet.private.id
# }*/

# #6)Create a NAT gateway for private subnets have access to internet

# ##########--- NAT Gateway ---##########
# # Create Elastic IP for the NAT Gateway
# /*resource "aws_eip" "Elastic_IPs_NATgw" {
#   #count  = length(var.public_subnet_cidrs)
#   vpc    = true

#   tags = {
#     Name = "EIP-NAT-Gateway"
#     #Name = "EIP-Public-Subnet${count.index + 1}"
#   }
# }

# #Create NAT Gateway resource and attach it to the VPC and public subnets
# #One NAT Gateway per AZ (3 NAT gateways)
# resource "aws_nat_gateway" "NAT_gateway" {
#   #count      = length(var.public_subnet_cidrs)
#   #allocation_id = aws_eip.Elastic_IPs_NATgw[*].id
#   #allocation_id = aws_eip.Elastic_IPs_NATgw[count.index].id
#   allocation_id = aws_eip.Elastic_IPs_NATgw.id
#   subnet_id = aws_subnet.public_subnets[0].id
#   #subnet_id = element(aws_subnet.public_subnets[*].id, count.index)

#   tags = {
#     Name = "NAT-gateway-AWS"
#     #Name = "NAT-gateway-${count.index + 1}"
#   }
#  }

# ##########--- RT Private Subnets ---##########
# #UCreate a new Route Table 1 for Private Subnets
#  resource "aws_route_table" "first_RT" {  
#  #count      = length(var.private_subnet_cidrs)
#  vpc_id     = aws_vpc.vpc_aws.id

#   route {
#    cidr_block = "0.0.0.0/0"            
#       #gateway_id = aws_nat_gateway.NAT_gateway[*].id
#       #gateway_id = aws_nat_gateway.NAT_gateway[count.index].id
#       gateway_id = aws_nat_gateway.NAT_gateway.id
#    }

#   tags = {
#    Name = "Private_Subnets_RT"
#   }  
#  }

# #Private subnets associated to Private_Subnets_RT
# resource "aws_route_table_association" "private_subnets_associations" {
#  count          = length(var.private_subnet_cidrs)
#  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
#  #route_table_id = aws_route_table.first_RT[*].id
#  #route_table_id = aws_route_table.first_RT[count.index].id
#  route_table_id = aws_route_table.first_RT.id
# }

# #7) Create Security group for EC2 instances
# resource "aws_security_group" "ssh-allowed" {
#     name   = "SSH Security Group"
#     description = "Enable SSH access on Port 22"
#     vpc_id = aws_vpc.vpc_aws.id

#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = -1
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     #Allow SSH transport
#     /*ingress {
#         description = "SSH access"
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         // This means, all ip address are allowed to ssh ! 
#         // Do not do it in the production. 
#         // Put your office or home address in it!
#         cidr_blocks = ["0.0.0.0/0"]
#     }*/

# /*    ingress {
#         from_port = 0
#         to_port = 0
#         protocol = -1
#         cidr_blocks = ["0.0.0.0/0"]
#     }  

#     tags   = {
#       Name = "SSH Security Group"
#     }
# }*/
# /*
# #8)Create EC2 instances
# resource "tls_private_key" "infraAWS" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# #Private key - The private key will be generated and stored locally on your working computer
# #Public key - Public key will be automatically uploaded to AWS.
# resource "aws_key_pair" "generated_key" {
#   #Name of key: Write the custom name of your key
#   key_name   = "infraAWS"
#   #Public Key: The public will be generated using the reference of tls_private_key.infraAWS-test
#   public_key = tls_private_key.infraAWS.public_key_openssh
#   #Store private key: generate and save private key(aws_keys_pairs.pem) in current directory 
#   provisioner "local-exec" {   
#     command = <<-EOT
#       echo '${tls_private_key.infraAWS.private_key_pem}' > infraAWS.pem
#       chmod 400 infraAWS.pem
#     EOT
#   }
# }

# #Sends your public key to the instance
# /*resource "aws_key_pair" "infra-aws" {
#   key_name = "infraAWS-test"
#   ##public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoHgPH91X/0CSputc8bCuV5jb22p+8xlmg10ADW3CrSw1z7YIF+fdnCFoYA+fmSLz+omOaMeRR+PilpBgZYVncwa1N7+gPrn210yw5Wk1CTmtHqV+nKn45oQpyJZuUBTHoQpmDVFFZbZjdEeRur3I7EDwa2dnOeDBTiFRz97NppnmmBkTxs7GWEl7GC0rFZ7/kfRvo/Ls6fvZlMW75tzgCu0C2ZRPwVLoPvrk0fc/dEFC28iGzToAhhMq2/EXYLpY/p2RarezMuEC/Qu0i0g8c296irpSygOYva+o4qfFKh7z736mOm4MScbIjDtTboRHLzrTC2OiQDz27iG/StiReNyZl6zHo+M7CiNVJNdGrY3HMsl1d21kBZrfpjIXP11GDO4L++23hsiupKTojGG1/fZbS3vRzBr0k8exFromqeaHT2VQDH95W4PK1mc7u+9Yl8dMwfcypQXKVUl3umAihfxvHKjvOu0e3j8oAFoE5XjTV0d4NObBxKbOVOD1peE8= laura_aristizabal_manjarres@mckinsey.com"
#   #public_key = file(var.key_pair)
#   public_key = file("mykeypair.pub")
# }*/
# /*
# resource "aws_instance" "ec2_public" {
#   ami = "${lookup(var.AMI, var.aws_region)}"
#   instance_type = "t2.micro"

#   # VPC
#   subnet_id = aws_subnet.public_subnets[0].id
#   # Security Group
#   vpc_security_group_ids = [aws_security_group.ssh-allowed.id]
#   # the Public SSH key
#   key_name = "${aws_key_pair.generated_key.key_name}"

#   tags = {
#     Name = "ec2_public"
#   }
# }

# resource "aws_instance" "ec2_private" {
#   ami = "${lookup(var.AMI, var.aws_region)}"
#   instance_type = "t2.micro"

#   # VPC
#   subnet_id = aws_subnet.private_subnets[0].id
#   # Security Group
#   vpc_security_group_ids = [aws_security_group.ssh-allowed.id]
#   # the Public SSH key
#   key_name = "${aws_key_pair.generated_key.key_name}"

#   tags = {
#     Name = "ec2_private"
#   }
# }*/

# /*module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "my-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = {
#     Terraform = "true"
#     Environment = "dev"
#   }

# }*/
