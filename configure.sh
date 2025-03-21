#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
cd /var/www/html/Frontend
sudo echo "CONFIG = { PUBLIC_IP: '$(curl -s ifconfig.me)' };" > config.js
cd /var/www/html/backend
wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
export $(aws ssm get-parameters --names "MONGO_URL" "PORT" --with-decryption --query "Parameters[*].[Name,Value]" --output text | awk '{print $1 "=" $2}')
sudo yum install -y nodejs
sudo npm install -g pm2
sudo pm2 start index.js
echo "Deployment complete and server restarted successfully."
