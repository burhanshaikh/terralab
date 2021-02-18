/*module "compute" {
 source = "../compute" 
}

module "database" {
 source = "../database" 
}*/

resource "aws_vpc" "vnet" {

        cidr_block = "10.1.0.0/16"
        enable_dns_hostnames = true
}

resource "aws_internet_gateway" "myig" {
  
        vpc_id = aws_vpc.vnet.id
        depends_on = [ aws_vpc.vnet ]
}

resource "aws_eip" "natip" {
  
        vpc = true
        depends_on = [ aws_vpc.vnet, aws_internet_gateway.myig ]
}

resource "aws_nat_gateway" "mynat" {

        allocation_id = aws_eip.natip.id
        subnet_id = aws_subnet.publicnet1.id
        depends_on = [ aws_internet_gateway.myig, aws_eip.natip ]
  
}

resource "aws_subnet" "publicnet1" {

        vpc_id = aws_vpc.vnet.id
        cidr_block = "10.1.1.0/24"
        map_public_ip_on_launch = true
        depends_on = [ aws_vpc.vnet ]
}

resource "aws_subnet" "publicnet2" {

        vpc_id = aws_vpc.vnet.id
        cidr_block = "10.1.2.0/24"
        map_public_ip_on_launch = true
        depends_on = [ aws_vpc.vnet ]
}

resource "aws_subnet" "publicnet3" {

        vpc_id = aws_vpc.vnet.id
        cidr_block = "10.1.3.0/24"
        map_public_ip_on_launch = true
        depends_on = [ aws_vpc.vnet ]
}

resource "aws_subnet" "privatenet1" {

        vpc_id = aws_vpc.vnet.id
        cidr_block = "10.1.4.0/24"
        availability_zone = "us-east-1a"
        map_public_ip_on_launch = true
        depends_on = [ aws_vpc.vnet, aws_nat_gateway.mynat ]
}

resource "aws_subnet" "privatenet2" {

        vpc_id = aws_vpc.vnet.id
        cidr_block = "10.1.5.0/24"
        availability_zone = "us-east-1b"
        map_public_ip_on_launch = true
        depends_on = [ aws_vpc.vnet, aws_nat_gateway.mynat ]
}

resource "aws_subnet" "privatenet3" {

        vpc_id = aws_vpc.vnet.id
        cidr_block = "10.1.6.0/24"
        availability_zone = "us-east-1a"
        map_public_ip_on_launch = true
        depends_on = [ aws_vpc.vnet, aws_nat_gateway.mynat ]
}

resource "aws_db_subnet_group" "dbnetgroup" {
  name       = "main"
  subnet_ids = [aws_subnet.privatenet1.id, aws_subnet.privatenet2.id]

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_route_table" "publicroute" {

        vpc_id = aws_vpc.vnet.id 
       route = [ {
         cidr_block = "0.0.0.0/0"
         gateway_id = aws_internet_gateway.myig.id
         egress_only_gateway_id = null
         instance_id = null
         ipv6_cidr_block = null
         local_gateway_id = null
         nat_gateway_id = null
         network_interface_id = null
         transit_gateway_id = null
         vpc_endpoint_id = null
         vpc_peering_connection_id = null
       } ]
        depends_on = [ aws_internet_gateway.myig ]
}

resource "aws_route_table_association" "publicassoc" {
        
        subnet_id = aws_subnet.publicnet1.id
        route_table_id = aws_route_table.publicroute.id
        depends_on = [ aws_route_table.publicroute ]
}

resource "aws_route_table" "privateroute" {
  
        vpc_id = aws_vpc.vnet.id
        route = [{
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.mynat.id
            egress_only_gateway_id = null
            gateway_id = null
            instance_id = null
            ipv6_cidr_block = null
            local_gateway_id = null
            network_interface_id = null
            transit_gateway_id = null
            vpc_endpoint_id = null
            vpc_peering_connection_id = null
        }]
        depends_on = [ aws_nat_gateway.mynat ]
}

resource "aws_route_table_association" "privateassoc" {
        
        subnet_id = aws_subnet.privatenet1.id
        route_table_id = aws_route_table.privateroute.id
        depends_on = [ aws_route_table.privateroute ]
}

resource "aws_security_group" "instancerules" {
  
        name = "Stronghold"
        description = "Security group for EC2 Instance and RDS"
        vpc_id = aws_vpc.vnet.id
        ingress = [ {
          cidr_blocks = [ "0.0.0.0/0" ]
          from_port = 22
          to_port = 22
          protocol = "tcp"
          ipv6_cidr_blocks = null
          prefix_list_ids = null
          security_groups = null
          self = false
          description = null
        },

        { cidr_blocks = [ "0.0.0.0/0" ]
          from_port = 5432
          to_port = 5432
          protocol = "tcp"
          ipv6_cidr_blocks = null
          prefix_list_ids = null
          security_groups = null
          self = false
          description = null
        }]

        egress = [ {
          cidr_blocks = [ "0.0.0.0/0" ]
          from_port = 0
          to_port = 0
          protocol = "-1"
          ipv6_cidr_blocks = null
          prefix_list_ids = null
          security_groups = null
          self = false
          description = null
        } ]
        

}

/*module "compute" {
 source = "../compute" 
}

module "database" {
 source = "../database" 
}*/