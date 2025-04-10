resource "aws_vpc" "kaizen" {
  cidr_block       = var.vpc[0].cidr_block
  enable_dns_support = var.vpc[0].enable_dns_support
  enable_dns_hostnames = var.vpc[0].enable_dns_hostnames
  tags = merge(local.common_tags, {
    Name = var.vpc[0].name
  })
}

output "vpc_id" {
  value = aws_vpc.kaizen.id
}

resource "aws_subnet" "public1" {
  cidr_block           = var.subnets[0].cidr_block
  availability_zone    = var.subnets[0].availability_zone
  vpc_id               = aws_vpc.kaizen.id
  map_public_ip_on_launch = var.subnets[0].auto_assign_public_ip
  tags = merge(local.common_tags, {
    Name = var.subnets[0].name
  })
}

resource "aws_subnet" "public2" {
  cidr_block           = var.subnets[1].cidr_block
  availability_zone    = var.subnets[1].availability_zone
  vpc_id               = aws_vpc.kaizen.id
  map_public_ip_on_launch = var.subnets[1].auto_assign_public_ip
  tags = merge(local.common_tags, {
    Name = var.subnets[1].name
  })
}

output "public" {
  value = [aws_subnet.public1.id, aws_subnet.public2.id]
}

resource "aws_subnet" "private1" {
  cidr_block           = var.subnets[2].cidr_block
  availability_zone    = var.subnets[2].availability_zone
  vpc_id               = aws_vpc.kaizen.id
  map_public_ip_on_launch = var.subnets[2].auto_assign_public_ip
  tags = merge(local.common_tags, {
    Name = var.subnets[2].name
  })
}

resource "aws_subnet" "private2" {
  cidr_block           = var.subnets[3].cidr_block
  availability_zone    = var.subnets[3].availability_zone
  vpc_id               = aws_vpc.kaizen.id
  map_public_ip_on_launch = var.subnets[3].auto_assign_public_ip
  tags = merge(local.common_tags, {
    Name = var.subnets[3].name
  })
}

output "private" {
  value = [aws_subnet.private1.id, aws_subnet.private2.id]
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.kaizen.id
  tags = merge(local.common_tags, {
    Name = "Internet Gateway"
  })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.kaizen.id
  tags = merge(local.common_tags, {
    Name = var.route_table_names[0]
  })
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.kaizen.id
  tags = merge(local.common_tags, {
    Name = var.route_table_names[1]
  })
}

resource "aws_route_table_association" "public_rt_association_1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_association_2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_association_1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_association_2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rt.id
}