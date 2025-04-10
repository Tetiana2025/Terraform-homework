resource "aws_key_pair" "deployer" {
  key_name   = var.aws_key
  public_key = file("~/.ssh/id_rsa.pub")

  tags = local.common_tags
}

output "key_pair_name" {
  description = "Name of the created Key Pair"
  value       = aws_key_pair.deployer.key_name
}