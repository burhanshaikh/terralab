variable "vpc_security_group_ids" {
  description = "Security group IDs for RDS instance"
}

variable "db_subnet_group_name" {
  description = "DB subnet group name that contains two subnets in different AZ's"
}