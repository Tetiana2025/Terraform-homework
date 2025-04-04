resource "aws_instance" "web" {
    count = 3
  ami           = "ami-03f8acd418785369b"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_tls.name]
  key_name = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)
  user_data = file("apache.sh")

  tags = {
    Name = "web-${count.index + 1}"
  }
}
    output "web_instance_ips" {
  value = aws_instance.web[*].public_ip
  }