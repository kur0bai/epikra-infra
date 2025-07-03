
sudo apt update && sudo apt install -y docker.io docker-compose git

# cloning epikra
git clone https://github.com/kur0bai/epikra.git /home/ubuntu/app

cd /home/ubuntu/app
sudo docker-compose up -d
