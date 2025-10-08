{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SSMGetParameter",
            "Effect": "Allow",
            "Action": "ssm:GetParameter",
            "Resource": "arn:aws:ssm:eu-west-2::parameter/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
        }
    ]
}