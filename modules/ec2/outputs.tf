output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "app_private_ip" {
  value = aws_instance.app.private_ip
}

output "key_name" {
  value = aws_key_pair.androvnyi_key.key_name
}
