provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}

module "key_pair" {
  source   = "../../modules/key_pair"
  key_name = var.key_name
  public_key_path  = "../../ssh/id_rsa_terraform.key.pub"
}

module "backend_sg" {
  source      = "../../modules/security_group"
  name        = "backend-sg"
  vpc_id      = data.aws_vpc.default.id
  description = "Allow SSH and HTTP for backend"

  ingress_rules = [
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
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "ec2_backend" {
  source             = "../../modules/ec2"
  ami                = var.aws_ami
  instance_type      = var.aws_instance_type
  key_name           = module.key_pair.key_name
  security_group_ids = [module.backend_sg.security_group_id]
  user_data          = "../../scripts/setup.sh"
  instance_name      = var.aws_instance_name
  environment        = "dev"
}
