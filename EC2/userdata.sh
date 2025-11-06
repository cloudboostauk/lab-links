#Note: This userdata is for Ubuntu AMI, so select Ubuntu as AMI while configuring your EC2
#please ignore the comments, copy and use the commands only

#command to update the OS
sudo apt-get update -y 

#command to add the Jenkins repo
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

#command to Import a key file from Jenkins-CI to enable installation from the package
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

#command to update the OS
sudo apt-get update -y 

#command to install java
sudo apt install openjdk-17-jre -y 

#command to install Jenkins
sudo apt-get install jenkins -y

#command to update the OS
apt-get update -y

#command to enable Jenkins
sudo systemctl enable jenkins

#command to start Jenkins
sudo systemctl start jenkins

#command to check Jenkins status
sudo systemctl status jenkins

#command to get Jenkins password
cat /var/lib/jenkins/secrets/initialAdminPassword