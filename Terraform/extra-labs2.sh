#Step 1
aws s3 rm s3://<your-bucket-name> --recursive --region us-west-1

#Step 2
aws s3api delete-bucket \
  --bucket <your-bucket-name> \
  --region us-west-1

# Step 3
aws dynamodb delete-table \
  --table-name terraform-locks \
  --region <region name>

