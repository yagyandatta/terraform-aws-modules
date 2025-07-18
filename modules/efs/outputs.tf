#---------------------------------------------#
# Outputs for AWS EFS module
#---------------------------------------------#

output "efs_id" {
  description = "The ID of the EFS file system"
  value       = aws_efs_file_system.this.id
}

output "efs_dns_name" {
  description = "DNS name for EFS access"
  value       = aws_efs_file_system.this.dns_name
}

output "mount_targets" {
  description = "Mount target IDs by subnet"
  value = {
    for subnet_id, mt in aws_efs_mount_target.this :
    subnet_id => mt.id
  }
}

output "security_group_id" {
  description = "Security group used for EFS mount targets"
  value       = aws_security_group.efs_sg.id
}
