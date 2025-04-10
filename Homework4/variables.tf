variable "aws_key" {
  default = "web-key"
  type    = string
}

variable "region" {
  default = "us-east-1"
  type    = string
}

variable "vpc" {
  type = list(object({
    cidr_block       = string
    enable_dns_support = bool
    enable_dns_hostnames = bool
    name = string
  }))
  default = [
    {
      cidr_block = "10.0.0.0/16"
      enable_dns_support = true
      enable_dns_hostnames = true
      name = "KaizenVPC"
    }
  ]
}

variable "subnets" {
  type = list(object({
    cidr_block         = string
    availability_zone  = string
    auto_assign_public_ip = bool
    name               = string
  }))
  default = [
    {
      cidr_block         = "10.0.1.0/24"
      availability_zone  = "us-east-1a"
      auto_assign_public_ip = true
      name               = "public1"
    },
    {
      cidr_block         = "10.0.2.0/24"
      availability_zone  = "us-east-1b"
      auto_assign_public_ip = true
      name               = "public2"
    },
    {
      cidr_block         = "10.0.3.0/24"
      availability_zone  = "us-east-1c"
      auto_assign_public_ip = false
      name               = "private1"
    },
    {
      cidr_block         = "10.0.4.0/24"
      availability_zone  = "us-east-1d"
      auto_assign_public_ip = false
      name               = "private2"
    }
  ]
}

variable "internet_gateway" {
  type    = string
  default = "igw-0aba38c114e4c4ba9"
}

variable "route_table_names" {
  type    = list(string)
  default = ["public-rt", "private-rt"]
}

variable "allowed_ports" {
  type    = list(number)
  default = [22, 80, 443, 3306]
}

variable "ec2_instance" {
  type = map(string)
  default = {
    ami_id         = "ami-00a929b66ed6e0de6"
    instance_type  = "t2.micro"
  }
}