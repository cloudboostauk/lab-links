# copy
aws ec2-instance-connect send-ssh-public-key \
    --instance-id PRIVATE-INSTANCE \
    --region eu-west-2 \
    --availability-zone eu-west-2a \
    --instance-os-user ec2-user \
    --ssh-public-key file:///home/ssm-user/.ssh/id_rsa.pub