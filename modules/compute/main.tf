
resource "aws_key_pair" "sshkey" {
  key_name = "vault1"
  public_key = file("/home/infracloud/Documents/key.pub")
}


resource "aws_instance" "vm" {
    
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.sshkey.key_name
    associate_public_ip_address = true
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids
    depends_on = [ aws_key_pair.sshkey ]

}