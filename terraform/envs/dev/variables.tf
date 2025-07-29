variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "key_name" {
 description = "Name of key pair"
 default= "devops-key"
}

variable "public_key_path" {
  description = "Path to the public key"
  default     = "/ssh/id_rsa_terraform.pub"
}

variable "aws_ami" {
  description = "Ubuntu AMI ID"
  default     = "ami-0c02fb55956c7d316"
}

variable "aws_instance_type" {
  description = "Instance type"
  default     = "t3.micro"
}


variable "aws_instance_name" {
  description = "Name tag for the EC2 instance"
  default     = "epikra-backend" 
}