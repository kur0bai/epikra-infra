resource "aws_instance" "jenkins" {
  ami                    = var.aws_ami
  instance_type          = var.aws_jenkins_instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y openjdk-11-jdk",
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update",
      "sudo apt install -y jenkins",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  tags = {
    Name = "Jenkins"
  }
}
