data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["137112412989"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "ubuntu_instance" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.bastion.key_name 
  user_data = file("apache-ubuntu.sh")
  
  tags = {
    Name = "Ubuntu"
  }
}

output "ubuntu_instance_public_ip" {
  value = aws_instance.ubuntu_instance.public_ip
}

resource "aws_instance" "amazon_instance" {
  ami           = data.aws_ami.amazon.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.bastion.key_name 
  user_data = file("apache-amazon.sh")
  
  tags = {
    Name = "Amazon"
  }
}

output "amazon_instance_public_ip" {
  value = aws_instance.amazon_instance.public_ip
}