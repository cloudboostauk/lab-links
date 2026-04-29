#!/bin/bash

#command to update the OS
sudo apt-get update -y 

# Update the OS
sudo apt-get update -y 

# Import the current Jenkins 2026 GPG key (LTS stable repo)
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add the Jenkins repo entry
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package index
sudo apt-get update -y 

# Install Java 21 (required for Jenkins)
sudo apt install fontconfig openjdk-21-jre -y 

# Install Jenkins
sudo apt-get install jenkins -y

# Enable and start Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Check status
sudo systemctl status jenkins

# Get initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
