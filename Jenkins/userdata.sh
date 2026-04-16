#!/bin/bash                                                                   
   
  # Update system                                                               
  sudo apt-get update -y                                          

  # Install Java 21 (required for Ubuntu 24.04)                                 
  sudo apt-get install -y openjdk-21-jdk
                                                                                
  # Jenkins repo                                                                
  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key                      
                                                                  
  echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]                 
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee        
  /etc/apt/sources.list.d/jenkins.list > /dev/null                              
                                                                  
  sudo apt-get update -y
  sudo apt-get install -y jenkins

  # Maven                                                                       
  sudo apt-get install -y maven
                                                                                
  # Docker                                                        
  sudo apt-get install -y docker.io
  sudo usermod -aG docker ubuntu                                                
  sudo usermod -aG docker jenkins                                               
  sudo systemctl enable docker                                                  
  sudo systemctl start docker                                                   
                                                                  
  # Start Jenkins properly as system service
  sudo systemctl enable jenkins
  sudo systemctl start jenkins

  # Terraform
  wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o
  /usr/share/keyrings/hashicorp-archive-keyring.gpg                             
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] 
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee        
  /etc/apt/sources.list.d/hashicorp.list                          
  sudo apt-get update -y                                                        
  sudo apt-get install -y terraform                               

  # AWS CLI
  sudo apt-get install -y unzip
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o            
  "awscliv2.zip"
  unzip -o awscliv2.zip                                                         
  sudo ./aws/install --update