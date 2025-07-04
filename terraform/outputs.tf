output "backend_public_ip" {
  value = aws_instance.backend.public_ip
}

## jenkins
/* output "jenkins_url" {
  value = "http://${aws_instance.jenkins.public_ip}:8080"
} */