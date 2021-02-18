variable "ami" {
  type = string
  default = "ami-047a51fa27710816e" # us-east-1 Amazon Linux 2 AMI

}

variable "instance_type" {
  type = string
  default = "t2.micro"
}