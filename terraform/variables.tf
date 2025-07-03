variable "region" {
  default = "us-east-1"
}

variable "key_name" {
  description = "Name of key pair"
  default= "devops-key"

}

variable "public_key_path" {
  description = "Path to public SSH key"
  default =  file("~/.ssh/id_rsa.pub")
}

variable "aws_instance_type" {
  default = "t3.micro"
}

variable "aws_ami" {
  description = "Ubuntu AMI ID"
  default     = "ami-0c02fb55956c7d316"
}
