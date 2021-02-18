output "publicsubnet1id" {
  value = aws_subnet.publicnet1.id
}

output "dbsubnetgroupname" {
  
  value = aws_db_subnet_group.dbnetgroup.name

}

output "securitygroupid" {
  
  value = aws_security_group.instancerules.id
}