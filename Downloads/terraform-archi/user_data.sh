#!/bin/bash
# Install Apache HTTP Server
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "<h1>Hello from 3-Tier Architecture EC2</h1>" > /var/www/html/index.html
