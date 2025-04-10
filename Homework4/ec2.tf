resource "aws_instance" "wordpress" {
  ami           = var.ec2_instance["ami_id"]
  instance_type = var.ec2_instance["instance_type"]
  
  tags = local.common_tags
}

output "ec2_instance_id" {
  value = aws_instance.wordpress.id
}