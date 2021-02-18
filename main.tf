module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"

  vpc_security_group_ids = [module.networking.securitygroupid]
  subnet_id = module.networking.publicsubnet1id
  depends_on = [ module.networking ]
}

module "database" {
  source = "./modules/database"

  
  vpc_security_group_ids = [module.networking.securitygroupid]
  db_subnet_group_name = module.networking.dbsubnetgroupname
  depends_on = [ module.networking, module.compute ]
}

