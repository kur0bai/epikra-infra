resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("${path.module}/ssh/id_rsa_terraform.key.pub")
}