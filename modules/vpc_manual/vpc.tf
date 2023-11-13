#1) AWS VPC
resource "aws_vpc" "vpc_aws" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default" //It's not dedicated, by default is cheaper than dedicated

  tags = {
    Name = "chupito"
  }
}
