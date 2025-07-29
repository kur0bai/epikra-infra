# Epikra Infra – Infrastructure as Code (IaC) with Terraform

This repository defines the basic infrastructure needed to deploy a **FastAPI** backend application in a minimal production-ready environment using **AWS** and **Terraform** for Infrastructure as Code (IaC). This is only for development stage if you want to expand and configure for production enviroment, cool.

## 🚀 Architecture

- **AWS EC2**  
  A `t3.micro` instance hosting the Dockerized FastAPI backend.

- **NGINX (Docker)**  
  Acts as a reverse proxy to route HTTP traffic to the FastAPI app.

- **PostgreSQL (Docker)**  
  Persistent database container, configured through environment variables.

- **SSH Key Pair**  
  Managed via Terraform to enable secure SSH access to the EC2 instance.

- **Security Group**  
  Allows HTTP (port 80) and SSH (port 22) access from authorized IPs.

- **GitHub Actions**  
  CI/CD workflow to automatically deploy the app to EC2 via SSH.

---

## 📁 Project Structure

```bash
infra/
│
├── envs
├── ├── dev/
│       ├── main.tf               # Main configuration for the dev environment
│       ├── variables.tf          # Dev-specific variables
│       ├── outputs.tf            # Useful outputs (e.g., public IP)
│
├── modules/
│   ├── ec2_backend/          # EC2 instance configuration for the backend
│   ├── key_pair/             # SSH key pair import
│   ├── security_group/       # Firewall rules (open ports)
│
├── ssh/ #You need to create this folder on your local (DO NOT SHARE/UPLOAD IT please)
│   ├── id_private.key      # Private SSH key
│   └── id_public.key.pub  # Public key used for EC2 access
```
