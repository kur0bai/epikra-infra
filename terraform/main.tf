#### Variables

variable "key_name" {
  description = "AWS Key pair"
  default= "devops-key"
}

variable "aws_instance_type" {
  description = "Type of instance in AWS"
  default = "t2.micro"
}
variable "aws_ami" {
  description = "AWS Machine Image"
  default = "ami-0c7217cdde317cfec"
}

### Basic setup

provider "aws" {
    region = "us-west-1"
}

resource "aws_key_pair" "dev_key" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "app_sg" {
  name        = "allow_web_ssh"
  description = "Allow SSH and HTTP"
  ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 8000
      to_port     = 8000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

resource "aws_instance" "epikra_ec2" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  key_name      = aws_key_pair.dev_key.key_name
  security_groups = [aws_security_group.app_sg.name]

  user_data = file("install_docker.sh")

  tags = {
    Name = "fastapi-instance"
  }
}