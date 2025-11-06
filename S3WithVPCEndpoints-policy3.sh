{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:Delete:Object",
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::daily-reports-375010115/*"
        }
    ]
}
