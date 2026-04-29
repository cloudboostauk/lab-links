#!/bin/bash
exec > >(tee /var/log/userdata.log | logger -t userdata -s 2>/dev/console) 2>&1

echo ">>> Starting userdata at $(date)"

export DEBIAN_FRONTEND=noninteractive

# ─────────────────────────────────────────────
# SYSTEM UPDATE
# ─────────────────────────────────────────────
sudo apt-get update -y
sudo apt-get upgrade -y

# ─────────────────────────────────────────────
# JAVA + JENKINS
# ─────────────────────────────────────────────
echo ">>> Installing Java & Jenkins..."

sudo apt-get install -y fontconfig openjdk-21-jre

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/" \
    | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins
echo ">>> Jenkins started"

# ─────────────────────────────────────────────
# MAVEN
# ─────────────────────────────────────────────
echo ">>> Installing Maven..."
sudo apt-get install -y maven

# ─────────────────────────────────────────────
# DOCKER (official repo)
# ─────────────────────────────────────────────
echo ">>> Installing Docker..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

sudo apt-get install -y ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins

sudo systemctl enable docker
sudo systemctl start docker
echo ">>> Docker started"

# ─────────────────────────────────────────────
# TERRAFORM
# ─────────────────────────────────────────────
echo ">>> Installing Terraform..."
sudo apt-get install -y unzip wget software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y terraform

# ─────────────────────────────────────────────
# AWS CLI v2
# ─────────────────────────────────────────────
echo ">>> Installing AWS CLI..."
cd /tmp
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -o awscliv2.zip
sudo ./aws/install --update
rm -rf awscliv2.zip aws/