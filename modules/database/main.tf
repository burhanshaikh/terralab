resource "aws_db_instance" "postgres" {
  allocated_storage    = 5
  storage_type         = "standard"
  engine               = "postgres"
  //engine_version       = "12.5"
  instance_class       = "db.t2.micro"
  name                 = "mypostgresdatabase"
  username             = "testdb"
  password             = "8characters"
  skip_final_snapshot = true
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name = var.db_subnet_group_name
  //security_group_names = [module.networking.securitygroupname]
  //db_subnet_group_name = module.networking.dbsubnetgroupname

}
