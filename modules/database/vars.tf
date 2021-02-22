variable "vpc_security_group_ids" {
  description = "Security group IDs for RDS instance"
}

variable "db_subnet_group_name" {
  description = "DB subnet group name that contains two subnets in different AZ's"
}

variable "allocated_storage" {
  default = 5
}

variable "storage_type" {
  default = "standard"
}

variable "engine" {
  default = "postgres"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "name" {
  default = "mypostgresdatabase"
}
variable "username" {
  default = "testdb"
  sensitive = true
}

variable "password" {
  default = "8characters"
  sensitive = true
}

variable "skip_final_snapshot" {
  type = bool
  default = true
}