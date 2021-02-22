variable "ami" {
  type = string
  default = "ami-047a51fa27710816e" # us-east-1 Amazon Linux 2 AMI

}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
  description = "ID of the subnet in which EC2 instance is to be deployed"
}

variable "vpc_security_group_ids" {
  description = "ID of the security group to be attached to the EC2 Instance"
}
