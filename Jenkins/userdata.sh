#!/bin/bash
set -e  # Exit on error
set -x 

# Update system
sudo apt-get update -y

# Install Java (Jenkins dependency - must be first)
sudo apt install openjdk-17-jre -y

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y

# Start Jenkins and wait for it to be ready
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Waiting for Jenkins to start..."
timeout 300 bash -c 'until curl -sf http://localhost:8080/login >/dev/null 2>&1; do sleep 5; echo "Still waiting..."; done' || echo "Jenkins may not be fully ready"

# Install Docker
sudo apt-get install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

# Add users to docker group
sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins

# Install other tools
sudo apt install python3-pip maven unzip awscli -y

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube /usr/local/bin/
rm minikube

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

# Install AWS CLI v2 (better than v1)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip

# Fix docker socket permissions
sudo chmod 666 /var/run/docker.sock

# Final restart of Jenkins to recognize docker group
echo "Restarting Jenkins to apply group changes..."
sudo systemctl restart jenkins