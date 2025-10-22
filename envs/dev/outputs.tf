output "bastion_public_ip" {
  description = "Public IP address of the Bastion host"
  value       = module.ec2.bastion_public_ip
}

output "app_private_ip" {
  description = "Private IP address of the App instance"
  value       = module.ec2.app_private_ip
}
