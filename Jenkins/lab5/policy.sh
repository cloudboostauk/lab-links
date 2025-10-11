{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SSMGetParameter",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter",
                "ssm:GetParameters"
            ],
            "Resource": [
                "arn:aws:ssm:*:*:parameter/aws/service/ami-amazon-linux-latest/*"
            ]
        }
    ]
}