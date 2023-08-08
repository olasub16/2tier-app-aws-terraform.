variable "region" {
  default = "ap-south-1"
}
variable "vpc_cidr" {
  default = "172.33.0.0/16"
}

variable "subnets" {
  type = list(string)
  default = ["webtier-public-subnet1","webtier-public-subnet2","dbtier-private-subnet1","dbtier-private-subnet2"]
}

variable "ec2_ami" {
  description = "AMI to Launch Instance"
  default =  "ami-0607784b46cbe5816"
}

variable "instance_type" {
  default = "t2.micro"
}




