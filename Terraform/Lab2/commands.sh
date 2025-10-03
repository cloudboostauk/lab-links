# Task 1 Step 1
aws s3api create-bucket \
--bucket <your-unique-bucket-name> \
--region <your-region> \
--create-bucket-configuration LocationConstraint=eu-west-2